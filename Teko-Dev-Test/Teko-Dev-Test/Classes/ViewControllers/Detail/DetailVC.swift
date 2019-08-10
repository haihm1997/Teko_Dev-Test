//
//  DetailVC.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/7/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

class DetailVC: BaseVC {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerPriceLabel: UILabel!
    @IBOutlet weak var cartNumberView: UIView!
    @IBOutlet weak var cartNumberLabel: UILabel!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedItem = SearchItem()
    var searchList = [SearchItem]()
    fileprivate let infoRowHeight: CGFloat = 462
    fileprivate let categoriesRowHeight: CGFloat = 242
    fileprivate let attributeRowHeight: CGFloat = 200
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        configTableView()
        getDetailItem()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: ACTIONS
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: FUNCTIONS
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ItemInfoCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ItemInfoCell.identifier)
        tableView.register(UINib(nibName: CategoriesCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CategoriesCell.identifier)
    }
    
    private func fillData() {
        headerLabel.text = selectedItem.name
        headerPriceLabel.text = Utils.toCurrencyFormat(selectedItem.price.sellPrice)
    }
    
    fileprivate func getDetailItem() {
        Address.Search.detailItemExcLink = Address.Search.baseDetailItem + "\(selectedItem.id)"
        showLoading()
        APIService.detailItem().subscribe(onNext: { [weak self] response in
            guard let weakSelf = self else { return }
            self?.dismissLoading()
            if response.code == ApiCode.success.rawValue {
                print("Success")
            } else {
                CustomDialog.shared().showSimpleAlert(message: "Có lỗi xảy ra", currentVC: weakSelf)
            }
        }).disposed(by: disposeBag)
    }
    
}

extension DetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case CellIndexPath.ItemInfoCell.rawValue:
            return setupItemInfoCell(indexPath: indexPath)
        case CellIndexPath.CategoriesCell.rawValue:
            return setupCategoriesCell(indexPath: indexPath)
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
        categoriesCell?.categoriesCellDelegate = self
        return categoriesCell ?? UITableViewCell()
    }
    
    fileprivate func reloadCategoryRow() {
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
//        switch indexPath.row {
//        case CellIndexPath.CategoriesCell.rawValue:
//            return UITableView.automaticDimension
//        default:
//            return UITableView.automaticDimension
//        }
        return UITableView.automaticDimension
    }
    
}

extension DetailVC: CategoriesCellDelegate {
    
    func didTapCompareButton() {
        reloadCategoryRow()
    }
    
    func didTapAttributeButton() {
        reloadCategoryRow()
    }
    
    func didTapDescButton() {
        reloadCategoryRow()
    }
    
    func cellDidChangedHeihgt() {
        self.tableView.reloadData()
    }
    
}

enum CellIndexPath: Int {
    case ItemInfoCell = 0
    case CategoriesCell = 1
    case SameTypeProductCell = 2
}
