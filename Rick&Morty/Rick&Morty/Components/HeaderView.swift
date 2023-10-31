//
//  HeaderView.swift
//  theok
//
//  Created by Adrian Lage Gil on 31/5/23.
//

import UIKit

class HeaderView: BaseComponent {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var menuImg: UIImageView!
    
    @IBOutlet weak var menuStackView: UIStackView!
    
    var vc : UIViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func nibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        menuImg.layer.cornerRadius = menuImg.bounds.height/2
        addSubview(view)
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        menuStackView.isHidden = !menuStackView.isHidden
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        vc?.dismiss(animated: true)
    }
    
    @IBAction func goHomeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "home_id") as! HomeVC
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .crossDissolve
        vc?.present(newVC, animated: true)
    }
    
    @IBAction func goCharactersAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Characters", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "characters_id") as! CharactersVC
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .crossDissolve
        vc?.present(newVC, animated: true)
    }

    @IBAction func goEpisodesAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Episodes", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "episodes_id") as! EpisodesVC
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .crossDissolve
        vc?.present(newVC, animated: true)
    }
    
    @IBAction func goLocAction(_ sender: Any) {
        /*
        let newVC = LocationsBuilder.buildLocationsModule()
        vc?.present(newVC, animated: true)
         */
    }
}
