//
//  AttributeItemCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/8/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

class AttributeItemCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    static let identifier = "AttributeItemCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - FUNCTIONS
    
    func fillData(item: Attribute?) {
        guard let item = item else { return }
        categoryLabel.text = item.name
        valueLabel.text = item.value
        self.contentView.backgroundColor = item.index % 2 == 0 ? Constants.Color.paleGrey : .white
    }

}
