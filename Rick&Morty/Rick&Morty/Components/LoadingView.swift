//
//  LoadingView.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 18/7/23.
//

import UIKit

class LoadingView: BaseComponent {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var loadImg: UIImageView!
    
    
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
        addSubview(view)
        
        loadImg.layer.cornerRadius = loadImg.bounds.height/2
    }
}
