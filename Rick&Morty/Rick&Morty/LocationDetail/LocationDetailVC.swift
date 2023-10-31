//
//  LocationDetailVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//

import UIKit
import Loaf

protocol ProtocolLocationDetailVC: AnyObject {
    func refreshView()
    func showServiceError()
    func reloadCollectionView()
}

class LocationDetailVC: ViewController, ProtocolLocationDetailVC {
    
    /// PROTOCOLS
    func refreshView() {
        setUpLocationData()
    }
    
    func showServiceError() {
        loadingView.isHidden = true
        Loaf("Data not found", state: .info, location: .bottom, sender: self).show()
    }
    
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var dimensionLbl: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var residentsLbl: UILabel!
    @IBOutlet weak var residentsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var loadingView: LoadingView!
    
    var protocolVM: ProtocolLocationDetailVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        headerView.vc = self
        headerView.titleLbl.text = "Location"
        
        residentsLbl.text = "Residents in this location"
        
        residentsCollectionView.delegate = self
        residentsCollectionView.dataSource = self
        residentsCollectionView.register(UINib(nibName: "ImgCharacterCell", bundle: nil), forCellWithReuseIdentifier: "ImgCharacterCell")
        
        getLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.loadImg.rotate()
    }
    
    func getLocation() {
        loadingView.isHidden = false
        protocolVM.getLocation()
    }
    
    func reloadCollectionView() {
        residentsCollectionView.reloadData()
    }
    
    func setUpLocationData() {
        nameLbl.text = protocolVM.location?.name
        typeLbl.text = protocolVM.location?.type
        dimensionLbl.text = protocolVM.location?.dimension
        infoView.isHidden = false
        loadingView.isHidden = true
        residentsCollectionView.reloadData()
    }

}


extension LocationDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return protocolVM.location?.residents.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = residentsCollectionView.dequeueReusableCell(withReuseIdentifier: "ImgCharacterCell", for: indexPath) as! ImgCharacterCell
        
        if let resident = Int(protocolVM.location?.residents[indexPath.item].split(separator: "/").last?.description ?? "") {
            cell.img.image = protocolVM.getCharacterImage(charID: resident)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resident = protocolVM.location?.residents[indexPath.item].split(separator: "/").last
        goToCharacterDetail(characterID: Int(resident?.description ?? "") ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionViewHeight.constant = residentsCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
}
