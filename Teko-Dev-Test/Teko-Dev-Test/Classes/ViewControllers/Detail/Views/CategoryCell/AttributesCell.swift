//
//  AttributesCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/10/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import FSPagerView

class AttributesCell: FSPagerViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var showMoreView: UIView!
    
    var didTapShowMore: ((_ tableCellHeight: CGFloat) -> ())?
    
    static let identifier = "AttributesCell"
    private let rowHeight: CGFloat = 35
    private let originParentCellHeight: CGFloat = 200
    
    // fake data to test lage of number attribute
//    let attributeList = [AttributeItem(index: 0, name: "Thương Hiệu 1", value: "Cooler Master"),
//                         AttributeItem(index: 1, name: "Thương Hiệu 2", value: "Cooler Master"),
//                         AttributeItem(index: 2, name: "Thương Hiệu 3", value: "Cooler Master"),
//                         AttributeItem(index: 3, name: "Thương Hiệu 4", value: "Cooler Master"),
//                         AttributeItem(index: 4, name: "Thương Hiệu 5", value: "Cooler Master"),
//                         AttributeItem(index: 5, name: "Thương Hiệu 6", value: "Cooler Master"),
//                         AttributeItem(index: 6, name: "Thương Hiệu 7", value: "Cooler Master"),
//                         AttributeItem(index: 7, name: "Thương Hiệu 7", value: "Cooler Master"),
//                         AttributeItem(index: 8, name: "Thương Hiệu 7", value: "Cooler Master"),
//                         AttributeItem(index: 9, name: "Thương Hiệu 7", value: "Cooler Master")
//                        ]
    
    var attributeList = [Attribute]()
    
    override func awakeFromNib() {
        configTableView()
        self.layer.shadowColor = UIColor.clear.cgColor
        configTransparentView()
        addShowMoreTapGesture()
        checkShowMoreViewVisibility()
    }
    
    // MARKS: FUNCTIONS
    
    private func checkShowMoreViewVisibility() {
        let realCellHeight = rowHeight * CGFloat(attributeList.count) + 24
        transparentView.isHidden = realCellHeight < originParentCellHeight
        bottomView.isHidden = transparentView.isHidden
    }
    
    private func configTableView() {
        tableView.register(UINib(nibName: AttributeItemCell.identifier, bundle: nil),
                           forCellReuseIdentifier: AttributeItemCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = rowHeight
        tableView.separatorColor = .clear
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
        let tableHeight = rowHeight * CGFloat(attributeList.count)
        tableViewHeight.constant = tableHeight
        bottomView.isHidden = true
        transparentView.isHidden = true
        didTapShowMore?(tableHeight)
    }
    
}

extension AttributesCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attributeCell = tableView.dequeueReusableCell(ofType: AttributeItemCell.self, for: indexPath)
        let item = attributeList[safe: indexPath.row]
        attributeCell?.fillData(item: item)
        return attributeCell ?? UITableViewCell()
    }
    
}
