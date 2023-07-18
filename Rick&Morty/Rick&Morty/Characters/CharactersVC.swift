//
//  CharactersVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//


import UIKit
import Loaf

class CharactersVC: ViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var filterBtn: UIButton!
    
    var characters: [Character] = []
    var images: [ImgSaved] = []
    
    lazy var charactersVM : CharactersVM = {
        let viewModel = CharactersVM()
        return viewModel
    }()
    
    var filters: String = ""
    var totalPags: Int = 0
    var pag: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.vc = self
        headerView.titleLbl.text = "Characters"
        
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        
        filterBtn.layer.cornerRadius = filterBtn.bounds.height/2
        
        images = UserDefaults.standard.getImages()
        getAllCharacters()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.loadImg.rotate()
    }
    
    // GET paged characters
    func getAllCharacters() {
        loadingView.isHidden = false
        charactersVM.getCharacters(page: pag, filters: filters){ [self] response in
            DispatchQueue.main.async { [self] in
                characters = characters + response.results
                setImages(chars: characters)
                totalPags = response.info.pages
                pag += 1
            }
        } failure: { [self] error in
            Loaf("Data not found", state: .info, location: .bottom, sender: self).show()
            loadingView.isHidden = true
        }
        
    }
    
    func getImage(urlImg: String) -> Data {
        let url = URL(string: urlImg)
        let data = try? Data(contentsOf: url!)
        return data ?? Data()
    }
    
    func setImages(chars: [Character]) {
        chars.map { char in
            if (!images.contains(where: {$0.id == char.id})) {
                UserDefaults.standard.addImage(data: ImgSaved(id: char.id, img: getImage(urlImg: char.image)))
            }
        }
        images = UserDefaults.standard.getImages()
        charactersTableView.reloadData()
        loadingView.isHidden = true
    }
    
    @IBAction func openFilters(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Filters", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "filters_id") as! FiltersVC
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in 560 })]
        }
        
        vc.modalTransitionStyle = .coverVertical
        vc.from = "characters"
        
        self.present(vc, animated: true)
    }
    
}

extension CharactersVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as! CharacterCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        let character = characters[indexPath.row]
        
        cell.name.text = character.name
        cell.setStatus(sts: character.status)
        cell.specie.text = character.species
        cell.gender.text = character.gender
        cell.type.text = character.type
        
        
        if let imageData = images.first(where: {$0.id == character.id})?.img {
            cell.img.image = UIImage(data: imageData)
        } else {
            cell.img.image = UIImage(named: "logo")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        goToCharacterDetail(characterID: character.id)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
            if (pag <= totalPags) {
                getAllCharacters()
            }
        }
    }
    
}
