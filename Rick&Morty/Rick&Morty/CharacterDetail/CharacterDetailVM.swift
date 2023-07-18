//
//  CharacterDetailVM.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//

import Foundation
import Alamofire

struct CharacterDetailVM {
    
    func getCharacter(charID: Int, succeed: (@escaping (Character) -> Void), failure: (@escaping (AFError) -> Void)) {
        RestApi.getRequestAF(endPoint: "character/\(charID)") { response in
            switch response.result {
            case .success(_):
                do {
                    let data: Character = try JSONDecoder().decode(Character.self, from: response.data!)
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
