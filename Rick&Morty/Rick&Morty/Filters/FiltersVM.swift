//
//  FiltersVM.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 25/10/23.
//

import Foundation
import UIKit

class FiltersVM {
    
    static var shared = FiltersVM()
    
    func filterEpisodes(name: String?, episode: String?) -> UIViewController {
        let storyboard = UIStoryboard(name: "Episodes", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "episodes_id") as! EpisodesVC
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .crossDissolve
        newVC.filters = "&name=\(name ?? "")&episode=\(episode ?? "")"
        return newVC
    }
    
    func filterLocations(name: String?, type: String?, dimension: String?) -> UIViewController {
        let newVC = LocationsBuilder.buildLocationsModule(filters: "&name=\(name ?? "")&type=\(type ?? "")&dimension=\(dimension ?? "")")
        return newVC
    }
    
    func filterCharacters(name: String?, type: String?, dimension: String?, specie: String?, status: String, gender: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Characters", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "characters_id") as! CharactersVC
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .crossDissolve
        newVC.filters = "&name=\(name ?? "")&type=\(type ?? "")&species=\(specie ?? "")&status=\(status)&gender=\(gender)"
        return newVC
    }

}
