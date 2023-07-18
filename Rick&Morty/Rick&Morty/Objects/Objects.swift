//
//  Objects.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//

import Foundation
import UIKit


// Character
public struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Origin
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

public struct Origin: Codable {
    let name: String
    let url: String
}

public struct Characters: Codable {
    let info: Info
    let results: [Character]
}

public struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

public struct ImgSaved: Codable {
    let id: Int
    let img: Data
}

public struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

public struct Episodes: Codable {
    let info: Info
    let results: [Episode]
}

public struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

public struct Locations: Codable {
    let info: Info
    let results: [Location]
}

