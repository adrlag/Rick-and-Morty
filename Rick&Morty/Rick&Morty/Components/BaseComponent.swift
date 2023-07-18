//
//  BaseComponent.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//


import UIKit

class BaseComponent: UIView {
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
}
