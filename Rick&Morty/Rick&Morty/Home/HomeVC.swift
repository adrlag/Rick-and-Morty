//
//  HomeVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 17/7/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
    }
    
    @IBAction func goToCharacters(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Characters", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "characters_id") as! CharactersVC
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .crossDissolve
        self.present(newVC, animated: true)
    }
    
    @IBAction func goToEpisodes(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Episodes", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "episodes_id") as! EpisodesVC
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .crossDissolve
        self.present(newVC, animated: true)
    }
    
    @IBAction func goToLocations(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Locations", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "locations_id") as! LocationsVC
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .crossDissolve
        self.present(newVC, animated: true)
    }
    
}

