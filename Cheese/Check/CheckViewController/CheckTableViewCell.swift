//
//  CheckTableViewCell.swift
//  Cheese
//
//  Created by Савелий Вепрев on 20/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
