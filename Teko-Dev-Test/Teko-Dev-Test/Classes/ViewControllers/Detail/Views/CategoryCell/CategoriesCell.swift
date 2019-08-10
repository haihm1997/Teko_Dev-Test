//
//  CategoriesCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/8/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import FSPagerView

protocol CategoriesCellDelegate: class {
    func didTapDescButton()
    func didTapAttributeButton()
    func didTapCompareButton()
    func cellDidChangedHeihgt()
}

class CategoriesCell: UITableViewCell {
    
    @IBOutlet weak var descItemButton: UIButton!
    @IBOutlet weak var attributeButton: UIButton!
    @IBOutlet weak var comparePriceButton: UIButton!
    @IBOutlet weak var descDecorView: UIView!
    @IBOutlet weak var attributeDecorView: UIView!
    @IBOutlet weak var compareDecorView: UIView!
    @IBOutlet weak var pageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.delegate = self
            self.pagerView.dataSource = self
            self.pagerView.bounces = false
            self.pagerView.register(UINib(nibName: AttributesCell.identifier, bundle: nil), forCellWithReuseIdentifier: AttributesCell.identifier)
            self.pagerView.register(UINib(nibName: DescriptionCell.identifier, bundle: nil), forCellWithReuseIdentifier: DescriptionCell.identifier)
            self.pagerView.register(UINib(nibName: CompareCell.identifier, bundle: nil), forCellWithReuseIdentifier: CompareCell.identifier)
        }
    }
    
    var categoriesCellDelegate: CategoriesCellDelegate?
    
    static let identifier = "CategoriesCell"
    var currentCellHeight: [Int: CGFloat] = [CategoriesCellIndex.DescCellType.rawValue: 200,
                                             CategoriesCellIndex.AttributeCellType.rawValue: 200,
                                             CategoriesCellIndex.CompareCellType.rawValue: 200]

    override func awakeFromNib() {
        super.awakeFromNib()
        configCategoryButtonAt(index: CategoriesCellIndex.DescCellType.rawValue)
    }

    // MARK: ACTIONS
    
    @IBAction func descButtonTapped(_ sender: Any) {
        configCategoryButtonAt(index: CategoriesCellIndex.DescCellType.rawValue)
        pagerView.scrollToItem(at: CategoriesCellIndex.DescCellType.rawValue, animated: false)
        updateTableCellHeight(currentIndex: CategoriesCellIndex.DescCellType.rawValue)
    }
    
    @IBAction func attributeButtonTapped(_ sender: Any) {
        configCategoryButtonAt(index: CategoriesCellIndex.AttributeCellType.rawValue)
        pagerView.scrollToItem(at: CategoriesCellIndex.AttributeCellType.rawValue, animated: false)
        updateTableCellHeight(currentIndex: CategoriesCellIndex.AttributeCellType.rawValue)
    }
    
    @IBAction func compareButtonTapped(_ sender: Any) {
        configCategoryButtonAt(index: CategoriesCellIndex.CompareCellType.rawValue)
        pagerView.scrollToItem(at: CategoriesCellIndex.CompareCellType.rawValue, animated: false)
        updateTableCellHeight(currentIndex: CategoriesCellIndex.CompareCellType.rawValue)
    }
    
    // MARK: FUNCTIONS
    
    private func configCategoryButtonAt(index: Int) {
        resetAllView()
        switch index {
        case CategoriesCellIndex.DescCellType.rawValue:
            descItemButton.setTitleColor(Constants.Color.darkGrey, for: .normal)
            descDecorView.backgroundColor = Constants.Color.tomato
        case CategoriesCellIndex.AttributeCellType.rawValue:
            attributeButton.setTitleColor(Constants.Color.darkGrey, for: .normal)
            attributeDecorView.backgroundColor = Constants.Color.tomato
        case CategoriesCellIndex.CompareCellType.rawValue:
            comparePriceButton.setTitleColor(Constants.Color.darkGrey, for: .normal)
            compareDecorView.backgroundColor = Constants.Color.tomato
        default:
            descItemButton.setTitleColor(Constants.Color.darkGrey, for: .normal)
            descDecorView.backgroundColor = Constants.Color.tomato
        }
    }
    
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
    
    fileprivate func updateTableCellHeight(currentIndex: Int) {
        self.pageViewHeight.constant = currentCellHeight[currentIndex] ?? 0
        self.categoriesCellDelegate?.cellDidChangedHeihgt()
    }
    
}

extension CategoriesCell: FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        switch index {
        case CategoriesCellIndex.DescCellType.rawValue:
            return setupDescriptionCell(content: "", index: index)
        case CategoriesCellIndex.AttributeCellType.rawValue:
            return setupAttributesCell(index: index)
        case CategoriesCellIndex.CompareCellType.rawValue:
            return setupCompareCell(index: index)
        default:
            return FSPagerViewCell()
        }
    }
    
    private func setupAttributesCell(index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: AttributesCell.identifier, at: index) as? AttributesCell else {
            return FSPagerViewCell()
        }
        cell.didTapShowMore = { tableHeight in
            let realCellHeight = tableHeight + 24
            self.pageViewHeight.constant = realCellHeight
            self.currentCellHeight.updateValue(realCellHeight, forKey: CategoriesCellIndex.AttributeCellType.rawValue)
            self.categoriesCellDelegate?.cellDidChangedHeihgt()
        }
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        return cell
    }
    
    // No design for cell
    private func setupDescriptionCell(content: String, index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: DescriptionCell.identifier, at: index) as? DescriptionCell else {
            return FSPagerViewCell()
        }
        let loremStr = "Lorem Ipsum is simply "
        cell.fillData(content: loremStr)
        cell.didTapShowMore = { contentViewHeight in
            let realTextViewHeight = contentViewHeight + 24
            self.pageViewHeight.constant = realTextViewHeight
            self.currentCellHeight.updateValue(realTextViewHeight, forKey: CategoriesCellIndex.DescCellType.rawValue)
            self.categoriesCellDelegate?.cellDidChangedHeihgt()
        }
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        return cell
    }
    
    // No design for cell
    private func setupCompareCell(index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CompareCell.identifier, at: index) as? CompareCell else {
            return FSPagerViewCell()
        }
        return cell
    }
    
}

extension CategoriesCell: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, shouldSelectItemAt index: Int) -> Bool {
        return false
    }
    
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
        configCategoryButtonAt(index: pagerView.currentIndex)
        updateTableCellHeight(currentIndex: pagerView.currentIndex)
    }
    
}

enum CategoriesCellIndex: Int {
    case DescCellType = 0
    case AttributeCellType = 1
    case CompareCellType = 2
}
