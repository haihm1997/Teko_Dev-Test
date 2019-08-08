//
//  CompareCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/9/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

class CompareCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    static let identifier = "CompareCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillData(content: String) {
        contentLabel.text = content
    }

}
