//
//  ItemInfoCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/8/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import FSPagerView

class ItemInfoCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCodeLabel: UILabel!
    @IBOutlet weak var notAvailableView: UIView!
    @IBOutlet weak var availableView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var tagView: TagView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.delegate = self
            self.pagerView.dataSource = self
            self.pagerView.register(UINib(nibName: ImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageCell.identifier)
            self.pagerView.automaticSlidingInterval = 3
            self.pagerView.isInfinite = true
        }
    }
    
    static let identifier = "ItemInfoCell"
    
    var currentItem = Product()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - FUNCTIONS
    
    private func configView() {
        // make gradient for available view
        Utils.makeGradientForView(availableView)
    }

    func fillData(item: Product) {
        self.currentItem = item
        itemNameLabel.text = item.name
        itemCodeLabel.text = item.id
        notAvailableView.isHidden = item.totalAvailable != 0
        availableView.isHidden = !notAvailableView.isHidden
        priceLabel.text = Utils.toCurrencyFormat(item.price.sellPrice)
        discountView.isHidden = item.discountPercent == 0
        tagView.isHidden = discountView.isHidden
        discountLabel.text = Utils.toCurrencyFormat(item.discount)
        tagView.discountLabel.text = "-\(item.discountPercent)%"
        pageControl.numberOfPages = item.imageUrlList.count
    }

}

// MARK: - PAGER VIEW DATA SOURCE

extension ItemInfoCell: FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return currentItem.imageUrlList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, at: index) as? ImageCell else {
            return FSPagerViewCell()
        }
        cell.fillData(imageUrl: currentItem.imageUrlList[safe: index] ?? "")
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        return cell
    }
    
}

// MARK: - PAGER VIEW DELEGATE

extension ItemInfoCell: FSPagerViewDelegate {
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
    }
    
}
