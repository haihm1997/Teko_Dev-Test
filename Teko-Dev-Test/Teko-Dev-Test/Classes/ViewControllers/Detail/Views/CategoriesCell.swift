//
//  CategoriesCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/8/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

protocol CategoriesCellDelegate: class {
    func didTapDescButton()
    func didTapAttributeButton()
    func didTapCompareButton()
}

class CategoriesCell: UITableViewCell {
    
    @IBOutlet weak var descItemButton: UIButton!
    @IBOutlet weak var attributeButton: UIButton!
    @IBOutlet weak var comparePriceButton: UIButton!
    @IBOutlet weak var descDecorView: UIView!
    @IBOutlet weak var attributeDecorView: UIView!
    @IBOutlet weak var compareDecorView: UIView!
    
    var categoriesCellDelegate: CategoriesCellDelegate?
    
    static let identifier = "CategoriesCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        attributeButton.setTitleColor(Constants.Color.darkGrey, for: .normal)
        attributeDecorView.backgroundColor = Constants.Color.tomato
    }

    // MARK: ACTIONS
    
    @IBAction func descButtonTapped(_ sender: Any) {
        resetAllView()
        descItemButton.setTitleColor(Constants.Color.darkGrey, for: .normal)
        descDecorView.backgroundColor = Constants.Color.tomato
        categoriesCellDelegate?.didTapDescButton()
    }
    
    @IBAction func attributeButtonTapped(_ sender: Any) {
        resetAllView()
        attributeButton.setTitleColor(Constants.Color.darkGrey, for: .normal)
        attributeDecorView.backgroundColor = Constants.Color.tomato
        categoriesCellDelegate?.didTapAttributeButton()
    }
    
    @IBAction func compareButtonTapped(_ sender: Any) {
        resetAllView()
        comparePriceButton.setTitleColor(Constants.Color.darkGrey, for: .normal)
        compareDecorView.backgroundColor = Constants.Color.tomato
        categoriesCellDelegate?.didTapCompareButton()
    }
    
    // MARK: FUNCTIONS
    
    private func resetAllView() {
        // Button
        descItemButton.setTitleColor(Constants.Color.coolGrey, for: .normal)
        attributeButton.setTitleColor(Constants.Color.coolGrey, for: .normal)
        comparePriceButton.setTitleColor(Constants.Color.coolGrey, for: .normal)
        
        // Decoration View
        descDecorView.backgroundColor = .clear
        attributeDecorView.backgroundColor = .clear
        compareDecorView.backgroundColor = .clear
    }
    
}
