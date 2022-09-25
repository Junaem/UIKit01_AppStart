//
//  MenuCell.swift
//  UIKit04_Setting_Clone
//
//  Created by 이준형 on 2022/09/25.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var midTitle: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
