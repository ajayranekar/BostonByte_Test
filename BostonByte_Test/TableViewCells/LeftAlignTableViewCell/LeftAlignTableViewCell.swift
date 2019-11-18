//
//  LeftAlignTableViewCell.swift
//  BostonByte_Test
//
//  Created by Apple on 16/11/19.
//  Copyright © 2019 Ajay Ranekar. All rights reserved.
//

import UIKit

class LeftAlignTableViewCell: UITableViewCell {

    @IBOutlet weak var myContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myContainerView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
