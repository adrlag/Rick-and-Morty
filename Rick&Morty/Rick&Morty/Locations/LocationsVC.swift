//
//  LocationsVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//

import UIKit
import Loaf

class LocationsVC: ViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var locationsTableView: UITableView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var loadingView: LoadingView!
    
    
    lazy var locationsVM : LocationsVM = {
        let viewModel = LocationsVM()
        return viewModel
    }()
    
    var filters: String = ""
    var pag: Int = 1
    var totalPags: Int = 0
    var locations: [Location] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.vc = self
        headerView.titleLbl.text = "Locations"
        
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        locationsTableView.register(UINib(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "LocationCell")
        
        filterBtn.layer.cornerRadius = filterBtn.bounds.height/2
        
        getAllLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.loadImg.rotate()
    }
    
    func getAllLocations() {
        loadingView.isHidden = false
        locationsVM.getLocations(page: pag, filters: filters) { response in
            DispatchQueue.main.async { [self] in
                locations = locations + response.results
                locationsTableView.reloadData()
                totalPags = response.info.pages
                pag += 1
                loadingView.isHidden = true
            }
        } failure: { [self] error in
            Loaf("Data not found", state: .info, location: .bottom, sender: self).show()
            loadingView.isHidden = true
        }
    }
    
    @IBAction func openFilters(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Filters", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "filters_id") as! FiltersVC
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in 350})]
        }
        
        vc.modalTransitionStyle = .coverVertical
        vc.from = "locations"
        
        self.present(vc, animated: true)
    }

}

extension LocationsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        let location = locations[indexPath.row]

        cell.nameLbl.text = location.name
        cell.typeLbl.text = location.type
        cell.dimensionsLbl.text = location.dimension

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        goToLocationDetail(locID: location.id)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
            if (pag <= totalPags) {
                getAllLocations()
            }
        }
    }
    
}

