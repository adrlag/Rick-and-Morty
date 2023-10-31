//
//  LocationsBuilder.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 30/10/23.
//

import Foundation
import UIKit


class LocationsBuilder {

    static func buildLocationsModule() -> LocationsVC {
        
        let viewModel = LocationsVM()
        let storyboard = UIStoryboard(name: "Locations", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "locations_id") as! LocationsVC
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        viewModel.protocolVC = viewController
        viewModel.api = RestApi.shared
        viewController.protocolVM = viewModel

        return viewController
    }
    
    static func buildLocationsModule(filters: String) -> LocationsVC {
        
        let viewModel = LocationsVM()
        let storyboard = UIStoryboard(name: "Locations", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "locations_id") as! LocationsVC
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        viewModel.protocolVC = viewController
        viewModel.api = RestApi.shared
        viewModel.setFilters(filters: filters)
        viewController.protocolVM = viewModel

        return viewController
    }
    
}
