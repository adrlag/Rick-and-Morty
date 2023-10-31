//
//  CharactersVM.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//


import Alamofire

struct CharactersVM {
    
    // MARK: GET EVENTS
    func getCharacters(page: Int, filters: String, succeed: (@escaping (Characters) -> Void), failure: (@escaping (AFError) -> Void)) {
        RestApi.shared.getRequestAF(endPoint: "character?page=\(page)\(filters)") { response in
            switch response.result {
            case .success(_):
                do {
                    let data: Characters = try JSONDecoder().decode(Characters.self, from: response.data!)
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

