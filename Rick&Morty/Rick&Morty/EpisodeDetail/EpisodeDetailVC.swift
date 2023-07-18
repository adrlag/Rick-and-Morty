//
//  EpisodeDetailVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//

import UIKit
import Loaf

class EpisodeDetailVC: ViewController {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var airDateLbl: UILabel!
    @IBOutlet weak var seasonLbl: UILabel!
    @IBOutlet weak var episodeLbl: UILabel!
    
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var charsEpisodeLbl: UILabel!
    @IBOutlet weak var loadingView: LoadingView!
    

    var episodeID: Int = 0
    
    var episode: Episode?
    var charactersImg: [ImgSaved] = []
    
    lazy var episodeDetailVM : EpisodeDetailVM = {
        let viewModel = EpisodeDetailVM()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.vc = self
        charsEpisodeLbl.text = "Characters in episode"
        
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = self
        episodesCollectionView.register(UINib(nibName: "ImgCharacterCell", bundle: nil), forCellWithReuseIdentifier: "ImgCharacterCell")
        
        getEpisode()
        charactersImg = UserDefaults.standard.getImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.loadImg.rotate()
    }
    
    func getEpisode() {
        loadingView.isHidden = false
        episodeDetailVM.getEpisode(episodeID: episodeID) { [self] response in
            DispatchQueue.main.async { [self] in
                episode = response
                setUpEpisodeData()
                episodesCollectionView.reloadData()
            }
        } failure: { [self] error in
            Loaf("Data not found", state: .info, location: .bottom, sender: self).show()
            loadingView.isHidden = true
        }

    }
    
    func setUpEpisodeData() {
        headerView.titleLbl.text = episode?.episode
        nameLbl.text = episode?.name
        airDateLbl.text = episode?.air_date
        var code = episode?.episode.replacingOccurrences(of: "E", with: "-")
        code = code?.replacingOccurrences(of: "S", with: "-")
        seasonLbl.text = "Season \(code?.split(separator: "-").first?.description ?? "")"
        episodeLbl.text = "Episode \(code?.split(separator: "-").last?.description ?? "")"
        infoView.isHidden = false
        loadingView.isHidden = true
    }

}

extension EpisodeDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episode?.characters.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodesCollectionView.dequeueReusableCell(withReuseIdentifier: "ImgCharacterCell", for: indexPath) as! ImgCharacterCell

        let character = episode?.characters[indexPath.item].split(separator: "/").last?.description
        
        if let imgSaved = charactersImg.first(where: {$0.id == Int(character ?? "0")})?.img {
            cell.img.image = UIImage(data: imgSaved)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let character = episode?.characters[indexPath.item].split(separator: "/").last {
            goToCharacterDetail(characterID: Int(character.description) ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionViewHeight.constant = episodesCollectionView.collectionViewLayout.collectionViewContentSize.height
    }

}


