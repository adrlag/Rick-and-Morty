//
//  LocationDetailVM.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//

import Foundation
import Alamofire

struct LocationDetailVM {
    
    func getLocation(locID: Int, succeed: (@escaping (Location) -> Void), failure: (@escaping (AFError) -> Void)) {
        RestApi.getRequestAF(endPoint: "location/\(locID)") { response in
            switch response.result {
            case .success(_):
                do {
                    let data: Location = try JSONDecoder().decode(Location.self, from: response.data!)
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
