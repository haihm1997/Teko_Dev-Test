//
//  DetailVC.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/7/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailVC: BaseVC {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerPriceLabel: UILabel!
    @IBOutlet weak var cartNumberView: UIView!
    @IBOutlet weak var cartNumberLabel: UILabel!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartContainerView: UIView!
    @IBOutlet weak var cartPriceLabel: UILabel!
    @IBOutlet weak var numberItemLabel: UILabel!
    
    var selectedItem = Product()
    var searchList = [Product]()
   // var detailItem = Detail()
    fileprivate let infoRowHeight: CGFloat = 462
    fileprivate let categoriesRowHeight: CGFloat = 242
    fileprivate let attributeRowHeight: CGFloat = 200
    var currentNumberItem = 1
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        configView()
        getDetailItem()
        configTableView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: ACTIONS
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func removeItemTapped(_ sender: Any) {
        if currentNumberItem > 1 {
            currentNumberItem -= 1
            setPriceForAllView()
        }
    }
    
    @IBAction func addItemTapped(_ sender: Any) {
        currentNumberItem += 1
        setPriceForAllView()
    }
    
    // MARK: - FUNCTIONS
    
    private func setPriceForAllView() {
        numberItemLabel.text = "\(currentNumberItem)"
        cartNumberLabel.text = "\(currentNumberItem)"
        let totalPrice = selectedItem.price.sellPrice * Float(currentNumberItem)
        cartPriceLabel.text = Utils.toCurrencyFormat(totalPrice)
    }
    
    private func configView() {
        tableView.isHidden = true
        Utils.makeGradientForView(cartContainerView)
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ItemInfoCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ItemInfoCell.identifier)
        tableView.register(UINib(nibName: CategoriesCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CategoriesCell.identifier)
        tableView.register(UINib(nibName: SameTypeCell.identifier, bundle: nil),
                           forCellReuseIdentifier: SameTypeCell.identifier)
    }
    
    private func fillData() {
        cartNumberLabel.text = "\(1)"
        numberItemLabel.text = "\(1)"
        cartPriceLabel.text = Utils.toCurrencyFormat(selectedItem.price.sellPrice)
        headerLabel.text = selectedItem.name
        headerPriceLabel.text = Utils.toCurrencyFormat(selectedItem.price.sellPrice)
    }
    
    private func getDetailItem() {
        Address.Search.detailItemExcLink = Address.Search.baseDetailItem + "\(selectedItem.id)"
        showLoading()
        APIService.detailItem().subscribe(onNext: { [weak self] response in
            guard let weakSelf = self else { return }
            self?.dismissLoading()
            if response.code == ApiCode.success.rawValue {
                if let product = response.data["product"] as? [String: Any] {
                    weakSelf.selectedItem.detail = Detail(json: JSON(product))
                }
                weakSelf.tableView.isHidden = false
                weakSelf.tableView.reloadData()
            } else {
                CustomDialog.shared().showSimpleAlert(message: "Có lỗi xảy ra", currentVC: weakSelf)
            }
        }).disposed(by: disposeBag)
    }
    
}

extension DetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case CellIndexPath.ItemInfoCell.rawValue:
            return setupItemInfoCell(indexPath: indexPath)
        case CellIndexPath.CategoriesCell.rawValue:
            return setupCategoriesCell(indexPath: indexPath)
        case CellIndexPath.SameTypeProductCell.rawValue:
            return setupSameTypeCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    private func setupItemInfoCell(indexPath: IndexPath) -> UITableViewCell {
        let itemInfoCell = tableView.dequeueReusableCell(ofType: ItemInfoCell.self, for: indexPath)
        itemInfoCell?.fillData(item: selectedItem)
        return itemInfoCell ?? UITableViewCell()
    }
    
    private func setupCategoriesCell(indexPath: IndexPath) -> UITableViewCell {
        let categoriesCell = tableView.dequeueReusableCell(ofType: CategoriesCell.self, for: indexPath)
        categoriesCell?.detailItem = selectedItem.detail
        categoriesCell?.didChangeCellHeight = {
            self.tableView.reloadData()
        }
        return categoriesCell ?? UITableViewCell()
    }
    
    private func setupSameTypeCell(indexPath: IndexPath) -> UITableViewCell {
        let sameTypeCell = tableView.dequeueReusableCell(ofType: SameTypeCell.self, for: indexPath)
        sameTypeCell?.itemList = searchList
        return sameTypeCell ?? UITableViewCell()
    }
    
    private func reloadCategoryRow() {
        self.tableView.reloadData()
    }
    
}

extension DetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case CellIndexPath.ItemInfoCell.rawValue:
            return infoRowHeight
        case CellIndexPath.CategoriesCell.rawValue:
            return categoriesRowHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case CellIndexPath.SameTypeProductCell.rawValue:
            return 298
        default:
            return UITableView.automaticDimension
        }
    }
    
}

enum CellIndexPath: Int {
    case ItemInfoCell = 0
    case CategoriesCell = 1
    case SameTypeProductCell = 2
}
