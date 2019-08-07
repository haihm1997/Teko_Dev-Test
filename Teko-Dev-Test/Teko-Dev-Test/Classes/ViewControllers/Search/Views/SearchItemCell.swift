//
//  SearchItemCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/7/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDiscountLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var tagView: TagView!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var dLabel: UILabel!
    
    static let identifier = "SearchItemCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    func configUI() {
        itemName.numberOfLines = 2
        itemName.textColor = Constants.Color.darkGrey
        itemPriceLabel.textColor = Constants.Color.tomato
        itemDiscountLabel.textColor = Constants.Color.coolGrey
        separateView.backgroundColor = Constants.Color.coolGrey
        dLabel.textColor = Constants.Color.tomato
        self.contentView.backgroundColor = Constants.Color.paleGrey
    }
    
    func fillData(item: SearchItem) {
        itemName.text = item.name
        itemPriceLabel.text = item.price.sellPrice == 0 ? "0" : Utils.toCurrencyFormat(item.price.sellPrice)
        discountView.isHidden = item.discountPercent == 0
        tagView.isHidden = item.discountPercent == 0
        itemDiscountLabel.text = Utils.toCurrencyFormat(item.discount)
        tagView.discountLabel.text = "-\(item.discountPercent)%"
        if !item.thumbnailUrl.isEmpty {
            if let url = URL(string: item.thumbnailUrl) {
                itemImage.af_setImage(withURL: url)
            }
        } else {
            itemImage.image = UIImage()
        }
    }

}
