//
//  SameTypeItemCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/10/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import AlamofireImage

class SameTypeItemCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var tagView: TagView!
    @IBOutlet weak var discountView: UIView!
    
    static let identifier = "SameTypeItemCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: FUNCTIONS
    
    func fillData(item: Product?) {
        guard let item = item else { return }
        if let url = URL(string: item.imageUrlList.first ?? "") {
            productImage.af_setImage(withURL: url)
        } else {
            productImage.image = UIImage()
        }
        nameLabel.text = item.name
        priceLabel.text = Utils.toCurrencyFormat(item.price.sellPrice)
        discountView.isHidden = item.discountPercent == 0
        tagView.isHidden = discountView.isHidden
        nameLabel.numberOfLines = discountView.isHidden ? 2 : 1
        discountPriceLabel.text = Utils.toCurrencyFormat(item.discount)
        tagView.discountLabel.text = "-\(item.discountPercent)%"
    }
    
}
