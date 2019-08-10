//
//  DescriptionCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/10/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import FSPagerView

class DescriptionCell: FSPagerViewCell {
    
    @IBOutlet weak var contentItemView: UITextView!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var showMoreView: UIView!
    
    var didTapShowMore: ((_ textViewHeight: CGFloat) -> ())?
    
    static let identifier = "DescriptionCell"
    let originParentCellHeight: CGFloat = 200
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.clear.cgColor
        configTransparentView()
        addShowMoreTapGesture()
    }
    
    // MARK: - FUNCTIONS
    
    func fillData(content: String) {
        contentItemView.text = content
        checkShowMoreViewVisibility()
    }
    
    private func checkShowMoreViewVisibility() {
        transparentView.isHidden = contentItemView.frame.height < originParentCellHeight
        bottomView.isHidden = transparentView.isHidden
    }
    
    private func configTransparentView() {
        let gradientLayer = CAGradientLayer()
        let topColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0).cgColor
        let bottomColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 80)
        gradientLayer.colors = [topColor, bottomColor]
        transparentView.backgroundColor = .clear
        transparentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addShowMoreTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showMoreTap))
        showMoreView.addGestureRecognizer(tapGesture)
    }
    
    @objc func showMoreTap() {
        bottomView.isHidden = true
        transparentView.isHidden = true
        didTapShowMore?(contentItemView.frame.height)
    }
    
}
