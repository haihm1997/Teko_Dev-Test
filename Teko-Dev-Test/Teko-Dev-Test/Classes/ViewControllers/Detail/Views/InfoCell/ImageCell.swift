//
//  ImageCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/8/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import AlamofireImage
import FSPagerView

class ImageCell: FSPagerViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    static let identifier = "ImageCell"
    
    func fillData(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            itemImageView.af_setImage(withURL: url)
        }
    }
    
}

