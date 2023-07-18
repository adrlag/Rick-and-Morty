//
//  LocationsVM.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//

import Foundation
import Alamofire

struct LocationsVM {
    
    func getLocations(page: Int, filters: String, succeed: (@escaping (Locations) -> Void), failure: (@escaping (AFError) -> Void)) {
        RestApi.getRequestAF(endPoint: "location?page=\(page)\(filters)") { response in
            switch response.result {
            case .success(_):
                do {
                    let data: Locations = try JSONDecoder().decode(Locations.self, from: response.data!)
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
    
}
