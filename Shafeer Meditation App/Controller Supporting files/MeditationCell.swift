//
//  MeditationCell.swift
//  Shafeer Meditation App
//
//  Created by Shafeer Puthalan on 16/04/19.
//  Copyright © 2019 Shafeer Puthalan. All rights reserved.
//

import UIKit

class MeditationCell: UITableViewCell {
   
    
    @IBOutlet weak var meditationImg: UIImageView!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
