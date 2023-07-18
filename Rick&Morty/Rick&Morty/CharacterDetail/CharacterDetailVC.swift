//
//  CharacterDetailVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//

import Foundation
import UIKit
import Loaf

class CharacterDetailVC: ViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var generalStackView: UIStackView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var specieLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var originLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var episodesAppearsLbl: UILabel!
    @IBOutlet weak var loadingView: LoadingView!
    
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    lazy var characterDetailVM : CharacterDetailVM = {
        let viewModel = CharacterDetailVM()
        return viewModel
    }()
    
    var characterID: Int = 0
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.vc = self
        
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = self
        
        episodesCollectionView.register(UINib(nibName: "TVCell", bundle: nil), forCellWithReuseIdentifier: "TVCell")
        
        episodesAppearsLbl.text = "Episodes where it appears"

        genderLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(genderFilter)))
        specieLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(specieFilter)))
        statusLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(statusFilter)))
        originLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToOrigin)))
        locationLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToLocation)))
        
        getCharacter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.loadImg.rotate()
    }
    
    func getCharacter() {
        loadingView.isHidden = false
        characterDetailVM.getCharacter(charID: characterID) { response in
            DispatchQueue.main.async { [self] in
                character = response
                setUpCharacterData()
                episodesCollectionView.reloadData()
            }
        } failure: { [self] error in
            Loaf("Data not found", state: .info, sender: self).show()
            loadingView.isHidden = true
        }
    }
    
    func setUpCharacterData() {
        headerView.titleLbl.text = character?.name
        img.layer.cornerRadius = img.bounds.height/2
        
        if let charImg = UserDefaults.standard.getImages().first(where: {$0.id == characterID}) {
            img.image = UIImage(data: charImg.img)
        } else {
            setImage(char: character!)
        }
        
        setStatus(sts: character?.status ?? "")
        specieLbl.text = character?.species
        typeLbl.text = character?.type
        genderLbl.text = character?.gender
        originLbl.text = character?.origin.name
        locationLbl.text = character?.location.name
        
        // MOSTRAR TODO EL CONTENIDO
        UIView.animate(withDuration: 3, delay: 0, options: .transitionCrossDissolve, animations: { [self] in
            generalStackView.isHidden = false
        })
        loadingView.isHidden = true
    }
    
    @objc func genderFilter() {
        let filters = "&gender=\(character?.gender ?? "")"
        goToFilterCharacters(filters: filters)
    }
    
    @objc func statusFilter() {
        let filters = "&status=\(character?.status ?? "")"
        goToFilterCharacters(filters: filters)
    }
    
    @objc func specieFilter() {
        let filters = "&species=\(character?.species ?? "")"
        goToFilterCharacters(filters: filters)
    }
    
    func setStatus(sts: String) {
        switch sts.lowercased() {
        case "alive":
            statusLbl.textColor = UIColor(named: "green_alive")
            statusLbl.text = sts
        case "dead":
            statusLbl.textColor = UIColor(named: "red_dead")
            statusLbl.text = sts
        default:
            statusLbl.textColor = UIColor(named: "orange_unknow")
            statusLbl.text = sts
        }
    }
    
    func getImage(urlImg: String) -> Data {
        let url = URL(string: urlImg)
        let data = try? Data(contentsOf: url!)
        return data ?? Data()
    }
    
    func setImage(char: Character) {
        UserDefaults.standard.addImage(data: ImgSaved(id: char.id, img: getImage(urlImg: char.image)))
        viewDidLoad()
    }
    
    @objc func goToLocation() {
        let storyboard = UIStoryboard(name: "LocationDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "location_detail_id") as! LocationDetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        if let id = Int(character?.location.url.split(separator: "/").last?.description ?? "") {
            vc.locationID = id
            self.present(vc, animated: true)
        } else {
            Loaf("Unknow location", state: .info, sender: self).show()
        }
    }
    
    @objc func goToOrigin() {
        let storyboard = UIStoryboard(name: "LocationDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "location_detail_id") as! LocationDetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        if let id = Int(character?.origin.url.split(separator: "/").last?.description ?? "") {
            vc.locationID = id
            self.present(vc, animated: true)
        } else {
            Loaf("Unknow origin", state: .info, sender: self).show()
        }
    }
    
}


extension CharacterDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return character?.episode.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodesCollectionView.dequeueReusableCell(withReuseIdentifier: "TVCell", for: indexPath) as! TVCell

        let episode = character?.episode[indexPath.item].split(separator: "/")
        
        cell.numLbl.text = episode?.last?.description
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let episode = character?.episode[indexPath.item].split(separator: "/").last?.description
        let id = Int(episode ?? "")
        goToEpisodeDetail(episodeID: id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionViewHeight.constant = episodesCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
}
