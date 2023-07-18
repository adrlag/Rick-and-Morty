//
//  LocationCell.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//

import UIKit

class LocationCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var dimensionsLbl: UILabel!
    
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
