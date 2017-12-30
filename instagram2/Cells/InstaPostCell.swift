//
//  InstaPostCell.swift
//  instagram2
//
//  Created by Gerard Recinto on 12/24/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class InstaPostCell: UITableViewCell {

  @IBOutlet weak var capLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
