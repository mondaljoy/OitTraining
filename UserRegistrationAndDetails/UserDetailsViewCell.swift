//
//  FormCellVCTableViewCell.swift
//  TableView
//
//  Created by JOY MONDAL on 9/1/17.
//  Copyright © 2017 OPTLPTP131. All rights reserved.
//

import UIKit

class FormCellVCTableViewCell: UITableViewCell {

    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
         profilePic.image = UIImage(named: "defaultImage")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
