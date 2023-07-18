//
//  EpisodeCell.swift
//  Rick&Morty
//
//  Created by Adrian Lage Gil on 15/7/23.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var numLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var seasonLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
