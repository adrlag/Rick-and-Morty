//
//  ActivityCell.swift
//  theok
//
//  Created by Adrian Lage Gil on 12/4/23.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView! {
        didSet {
            img.layer.cornerRadius = img.frame.height/2
        }
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var specie: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var baseView: UIView!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setStatus(sts: String) {
        switch sts.lowercased() {
        case "alive":
            status.textColor = UIColor(named: "green_alive")
            status.text = sts
        case "dead":
            status.textColor = UIColor(named: "red_dead")
            status.text = sts
        default:
            status.textColor = UIColor(named: "orange_unknow")
            status.text = sts
        }
    }
    
}
