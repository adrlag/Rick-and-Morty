//
//  FiltersVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 17/7/23.
//

import UIKit

class FiltersVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var statusStackView: UIStackView!
    @IBOutlet weak var genderStackView: UIStackView!
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var episodeTF: UITextField!
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var dimensionTF: UITextField!
    @IBOutlet weak var specieTF: UITextField!
    
    var from: String = ""
    var status: String = ""
    var gender: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.delegate = self
        episodeTF.delegate = self
        typeTF.delegate = self
        dimensionTF.delegate = self
        specieTF.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch from {
        case "characters": setUpFilterCharacters()
        case "episodes": setUpFilterEpisodes()
        case "locations": setUpFilterLocations()
        default:
            nameTF.isHidden = false
        }
    }
    
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
    
    func setUpFilterEpisodes() {
        episodeTF.isHidden = false
        nameTF.isHidden = false
    }
    
    func setUpFilterLocations() {
        nameTF.isHidden = false
        typeTF.isHidden = false
        dimensionTF.isHidden = false
    }
    
    func setUpFilterCharacters() {
        nameTF.isHidden = false
        typeTF.isHidden = false
        specieTF.isHidden = false
        statusStackView.isHidden = false
        genderStackView.isHidden = false
    }
    
    @IBAction func cleanAll(_ sender: UIButton) {
        nameTF.text = ""
        episodeTF.text = ""
        typeTF.text = ""
        dimensionTF.text = ""
        specieTF.text = ""
        status = ""
        statusLbl.text = ""
        gender = ""
        genderLbl.text = ""
    }
    
    @IBAction func selectGender(_ sender: UIButton) {
        switch sender.tag {
        case 0: gender = "female"
        case 1: gender = "male"
        case 2: gender = "genderless"
        case 3: gender = "unknow"
        default: gender = ""
        }
        genderLbl.text = sender.titleLabel?.text
    }
    
    @IBAction func selectStatus(_ sender: UIButton) {
        switch sender.tag {
        case 0: status = "alive"
        case 1: status = "dead"
        case 2: status = "unknow"
        default: status = ""
        }
        statusLbl.text = sender.titleLabel?.text
    }
    
    @IBAction func applyFilters(_ sender: Any) {
        var newVC = UIViewController()
        switch from {
        case "characters":
            newVC = FiltersVM.shared.filterCharacters(name: nameTF.text, type: typeTF.text, dimension: dimensionTF.text, specie: specieTF.text, status: status, gender: gender)
        case "episodes":
            newVC = FiltersVM.shared.filterEpisodes(name: nameTF.text, episode: episodeTF.text)
        case "locations":
            newVC = FiltersVM.shared.filterLocations(name: nameTF.text, type: typeTF.text, dimension: dimensionTF.text)
        default:
            print("*** BAD FILTER")
        }
        self.present(newVC, animated: true)
    }
}
