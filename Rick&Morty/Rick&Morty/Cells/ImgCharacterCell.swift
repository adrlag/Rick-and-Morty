//
//  ImgCharacterCelll.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//

import UIKit

class ImgCharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView! {
        didSet {
            img.layer.cornerRadius = 45
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
