//
//  LocationDetailBuilder.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 31/10/23.
//

import Foundation
import UIKit


class LocationDetailBuilder {
    
    static func buildLocationDetailModule(locID: Int) -> LocationDetailVC {
        
        let viewModel = LocationDetailVM()
        let storyboard = UIStoryboard(name: "LocationDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "location_detail_id") as! LocationDetailVC
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        viewModel.locationID = locID
        viewModel.protocolVC = viewController
        viewModel.api = RestApi.shared
        viewController.protocolVM = viewModel
        
        return viewController
    }
    
}
