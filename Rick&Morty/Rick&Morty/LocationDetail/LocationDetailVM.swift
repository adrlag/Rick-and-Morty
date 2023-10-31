//
//  LocationDetailVM.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//

import Foundation
import Alamofire

protocol ProtocolLocationDetailVM: AnyObject {
    var location: Location? { get }
    
    func getLocation()
    func getCharacterImage(charID: Int) -> UIImage
}

class LocationDetailVM: ProtocolLocationDetailVM {

    
    /// PROTOCOLS
    func getLocation() {
        getLocation(locID: locationID) { [self] response in
            protocolVC.refreshView()
        } failure: { [self] error in
            protocolVC.showServiceError()
        }
        getSavedImages()
    }
    
    func getCharacterImage(charID: Int) -> UIImage {
        var result = UIImage(named: "logo")!
        if let imgSaved = charactersImg.first(where: {$0.id == charID})?.img {
            result = UIImage(data: imgSaved) ?? UIImage(named: "logo")!
        }
        return result
    }
    
    var location: Location?
    var locationID: Int = 0
    var charactersImg: [ImgSaved] = []
    
    weak var protocolVC: ProtocolLocationDetailVC!
    weak var api: RestApi!
    
    func getLocation(locID: Int, succeed: (@escaping (Location) -> Void), failure: (@escaping (AFError) -> Void)) {
        api.getRequestAF(endPoint: "location/\(locID)") { [self] response in
            switch response.result {
            case .success(_):
                do {
                    let data: Location = try JSONDecoder().decode(Location.self, from: response.data!)
                    location = data
                    succeed(data)
                } catch {
                    failure(AFError.explicitlyCancelled)
                }
            case .failure(_):
                failure(response.error!)
            }
        } failure: { error in
            failure(error)
        }
    }
    
    func getSavedImages() {
        charactersImg = UserDefaults.standard.getImages()
        protocolVC.reloadCollectionView()
    }
}
