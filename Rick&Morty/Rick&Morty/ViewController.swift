//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 14/7/23.
//

import UIKit
import Loaf

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func goToCharacterDetail(characterID: Int) {
        let storyboard = UIStoryboard(name: "CharacterDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "character_detail_id") as! CharacterDetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.characterID = characterID
        self.present(vc, animated: true)
    }
    
    func goToEpisodeDetail(episodeID: Int) {
        let storyboard = UIStoryboard(name: "EpisodeDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "episode_detail_id") as! EpisodeDetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.episodeID = episodeID
        self.present(vc, animated: true)
    }
    
    func goToLocationDetail(locID: Int) {
        let storyboard = UIStoryboard(name: "LocationDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "location_detail_id") as! LocationDetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.locationID = locID
        self.present(vc, animated: true)
    }

    func goToFilterCharacters(filters: String) {
        let storyboard = UIStoryboard(name: "Characters", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "characters_id") as! CharactersVC
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .crossDissolve
        newVC.filters = filters
        self.present(newVC, animated: true)
    }

}

