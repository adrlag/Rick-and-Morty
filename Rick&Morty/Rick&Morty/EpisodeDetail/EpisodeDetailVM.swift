//
//  EpisodeDetailVM.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//

import Foundation
import Alamofire

struct EpisodeDetailVM {
    
    func getEpisode(episodeID: Int, succeed: (@escaping (Episode) -> Void), failure: (@escaping (AFError) -> Void)) {
        RestApi.shared.getRequestAF(endPoint: "episode/\(episodeID)") { response in
            switch response.result {
            case .success(_):
                do {
                    let data: Episode = try JSONDecoder().decode(Episode.self, from: response.data!)
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
