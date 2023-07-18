//
//  EpisodesVC.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 16/7/23.
//

import UIKit
import Loaf

class EpisodesVC: ViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var episodesTableView: UITableView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var loadingView: LoadingView!
    
    
    lazy var episodesVM : EpisodesVM = {
        let viewModel = EpisodesVM()
        return viewModel
    }()
    
    var filters: String = ""
    var pag: Int = 1
    var totalPags: Int = 0
    var episodes: [Episode] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.vc = self
        headerView.titleLbl.text = "Episodes"
        
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        episodesTableView.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        
        filterBtn.layer.cornerRadius = filterBtn.bounds.height/2
        
        getAllEpisodes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.loadImg.rotate()
    }
    
    func getAllEpisodes() {
        loadingView.isHidden = false
        episodesVM.getEpisodes(page: pag, filters: filters) { response in
            DispatchQueue.main.async { [self] in
                episodes = episodes + response.results
                episodesTableView.reloadData()
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
            sheet.detents = [.custom(resolver: { context in 300 })]
        }
        
        vc.modalTransitionStyle = .coverVertical
        vc.from = "episodes"
        
        self.present(vc, animated: true)
    }
    
}

extension EpisodesVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell") as! EpisodeCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        let episode = episodes[indexPath.row]
        
        cell.numLbl.text = "Episode \(episode.id)"
        cell.titleLbl.text = episode.name
        cell.seasonLbl.text = episode.episode
        cell.dateLbl.text = episode.air_date

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        goToEpisodeDetail(episodeID: episode.id)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
            if (pag <= totalPags) {
                getAllEpisodes()
            }
        }
    }
    
}

