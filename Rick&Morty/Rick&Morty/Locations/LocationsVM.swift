//
//  LocationsVM.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//

import Foundation
import Alamofire


protocol ProtocolLocationsVM: AnyObject {
    var locations: [Location] { get }
    func getAllLocations()
    func moreData() -> Bool
}

class LocationsVM: ProtocolLocationsVM {
    
    /// PROTOCOLS
    func getAllLocations() {
        self.getLocations { [self] response in
            protocolVC.updateTable()
        } failure: { [self] error in
            protocolVC.showServiceError()
        }
    }
    
    func moreData() -> Bool {
        return (page <= totalPages)
    }
    
    var filters: String = ""
    var page: Int = 1
    var locations: [Location] = []
    var totalPages: Int = 0
    
    weak var protocolVC: ProtocolLocationsVC!
    weak var api: RestApi!

    func setFilters(filters: String) {
        self.filters = filters
        protocolVC.hideFilterBtn()
    }
    
    func getLocations(succeed: (@escaping ([Location]) -> Void), failure: (@escaping (AFError) -> Void)) {
        api.getRequestAF(endPoint: "location?page=\(page)\(filters)") { [self] response in
            switch response.result {
            case .success(_):
                do {
                    let data: Locations = try JSONDecoder().decode(Locations.self, from: response.data!)
                    locations = locations + data.results
                    totalPages = data.info.pages
                    page += 1
                    succeed(locations)
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
}
