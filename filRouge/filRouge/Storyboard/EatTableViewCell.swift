//
//  EatTableViewCell.swift
//  filRouge
//
//  Created by Student04 on 01/09/2021.
//

import UIKit

class EatTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var nomResto: UILabel!
    @IBOutlet weak var iconeLocalisation: UIImageView!
    @IBOutlet weak var ville: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var iconeEnter: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
