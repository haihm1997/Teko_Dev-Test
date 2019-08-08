//
//  DescriptionItemCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/9/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

class DescriptionItemCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    static let identifier = "DescriptionItemCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillData(content: String) {
        contentLabel.text = content
    }

}
