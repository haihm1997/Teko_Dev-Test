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
    var currentCategory = CategoriesCellType.AttributeCellType
    
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
        tableView.register(UINib(nibName: AttributeCell.identifier, bundle: nil),
                           forCellReuseIdentifier: AttributeCell.identifier)
        tableView.register(UINib(nibName: DescriptionItemCell.identifier, bundle: nil),
                           forCellReuseIdentifier: DescriptionItemCell.identifier)
        tableView.register(UINib(nibName: CompareCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CompareCell.identifier)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case CellIndexPath.ItemInfoCell.rawValue:
            return setupItemInfoCell(indexPath: indexPath)
        case CellIndexPath.CategoriesCell.rawValue:
            return setupCategoriesCell(indexPath: indexPath)
        case CellIndexPath.AttributeCell.rawValue:
            return switchCategoryCellItem(indexPath: indexPath)
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
    
    private func switchCategoryCellItem(indexPath: IndexPath) -> UITableViewCell {
        switch currentCategory {
        case .DescCellType:
            return setupDescriptionCell(indexPath: indexPath)
        case .AttributeCellType:
            return setupAttributeCell(indexPath: indexPath)
        case .CompareCellType:
            return setupCompareCell(indexPath: indexPath)
        }
    }
    
    private func setupAttributeCell(indexPath: IndexPath) -> UITableViewCell {
        let attributeCell = tableView.dequeueReusableCell(ofType: AttributeCell.self, for: indexPath)
        attributeCell?.didTapShowMore = {
            self.reloadCategoryRow()
        }
        return attributeCell ?? UITableViewCell()
    }
    
    private func setupDescriptionCell(indexPath: IndexPath) -> UITableViewCell {
        let descriptionCell = tableView.dequeueReusableCell(ofType: DescriptionItemCell.self, for: indexPath)
        descriptionCell?.fillData(content: "The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps. Bawds jog, flick quartz, vex nymphs. Waltz, bad nymph, for quick jigs vex! Fox nymphs grab quick-jived waltz. Brick quiz whangs jumpy veldt")
        return descriptionCell ?? UITableViewCell()
    }
    
    private func setupCompareCell(indexPath: IndexPath) -> UITableViewCell {
        let compareCell = tableView.dequeueReusableCell(ofType: CompareCell.self, for: indexPath)
        compareCell?.fillData(content: "Compare Product")
        return compareCell ?? UITableViewCell()
    }
    
    fileprivate func reloadCategoryRow() {
        let indexPath = IndexPath(item: CellIndexPath.AttributeCell.rawValue, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

extension DetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case CellIndexPath.ItemInfoCell.rawValue:
            return 462
        case CellIndexPath.CategoriesCell.rawValue:
            return 42
        case CellIndexPath.AttributeCell.rawValue:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case CellIndexPath.CategoriesCell.rawValue:
            return 42
        default:
            return UITableView.automaticDimension
        }
    }
    
}

extension DetailVC: CategoriesCellDelegate {
    
    func didTapCompareButton() {
        currentCategory = .CompareCellType
        reloadCategoryRow()
    }
    
    func didTapAttributeButton() {
        currentCategory = .AttributeCellType
        reloadCategoryRow()
    }
    
    func didTapDescButton() {
        currentCategory = .DescCellType
        reloadCategoryRow()
    }
}

enum CategoriesCellType: Int {
    case DescCellType = 0
    case AttributeCellType = 1
    case CompareCellType = 2
}

enum CellIndexPath: Int {
    case ItemInfoCell = 0
    case CategoriesCell = 1
    case AttributeCell = 2
    case SameTypeProductCell = 3
}
