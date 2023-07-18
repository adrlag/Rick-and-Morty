//
//  EpisodesVM.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//

import Foundation
import Alamofire

struct EpisodesVM {
    
    func getEpisodes(page: Int, filters: String, succeed: (@escaping (Episodes) -> Void), failure: (@escaping (AFError) -> Void)) {
        RestApi.getRequestAF(endPoint: "episode?page=\(page)\(filters)") { response in
            switch response.result {
            case .success(_):
                do {
                    let data: Episodes = try JSONDecoder().decode(Episodes.self, from: response.data!)
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
