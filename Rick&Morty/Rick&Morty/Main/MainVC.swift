//
//  MainVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        img.layer.cornerRadius = img.bounds.height/2
        img.rotate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        goToHome()
    }
    
    
    func goToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "home_id") as! HomeVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
}
