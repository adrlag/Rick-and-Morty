//
//  LocationDetailVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//

import UIKit
import Loaf

class LocationDetailVC: ViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var dimensionLbl: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var residentsLbl: UILabel!
    @IBOutlet weak var residentsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var loadingView: LoadingView!
    
    
    lazy var locationDetailVM : LocationDetailVM = {
        let viewModel = LocationDetailVM()
        return viewModel
    }()
    
    var locationID: Int = 0
    var location: Location?
    
    var charactersImg: [ImgSaved] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
        headerView.vc = self
        headerView.titleLbl.text = "Location"
        
        residentsLbl.text = "Residents in this location"
        
        residentsCollectionView.delegate = self
        residentsCollectionView.dataSource = self
        residentsCollectionView.register(UINib(nibName: "ImgCharacterCell", bundle: nil), forCellWithReuseIdentifier: "ImgCharacterCell")
        
        charactersImg = UserDefaults.standard.getImages()
        getLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.loadImg.rotate()
    }
    
    func getLocation() {
        loadingView.isHidden = false
        locationDetailVM.getLocation(locID: locationID) { [self] response in
            DispatchQueue.main.async { [self] in
                location = response
                setUpLocationData()
                residentsCollectionView.reloadData()
            }
        } failure: { [self] error in
            Loaf("Data not found", state: .info, location: .bottom, sender: self).show()
            loadingView.isHidden = true
        }
    }
    
    func setUpLocationData() {
        nameLbl.text = location?.name
        typeLbl.text = location?.type
        dimensionLbl.text = location?.dimension
        infoView.isHidden = false
        loadingView.isHidden = true
    }
    
}


extension LocationDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return location?.residents.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = residentsCollectionView.dequeueReusableCell(withReuseIdentifier: "ImgCharacterCell", for: indexPath) as! ImgCharacterCell
        
        let resident = location?.residents[indexPath.item].split(separator: "/").last?.description
        
        if let imgSaved = charactersImg.first(where: {$0.id == Int(resident ?? "0")})?.img {
            cell.img.image = UIImage(data: imgSaved)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resident = location?.residents[indexPath.item].split(separator: "/").last
        goToCharacterDetail(characterID: Int(resident?.description ?? "") ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionViewHeight.constant = residentsCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
}
