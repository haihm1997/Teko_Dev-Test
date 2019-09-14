//
//  SearchVC.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

class SearchVC: BaseVC {
    
    @IBOutlet weak var containerSearchView: UIView!
    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResult = [Product]()
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        configTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configSearchView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - CONFIGS
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SearchItemCell.identifier, bundle: nil),
                           forCellReuseIdentifier: SearchItemCell.identifier)
        tableView.isEmptyRowsHidden = true
        tableView.rowHeight = 110
        tableView.separatorColor = .clear
    }
    
    private func configSearchView() {
        // set height for container search view
        let subSearchViewHeight: CGFloat = 48
        searchViewHeight.constant = UIScreen.statusBarHeight + subSearchViewHeight
        
        // set gradient for container view
        Utils.makeGradientForView(containerSearchView)
    }
    
    // MARK: - NAVIGATIONS
    
    private func showDetailProduct(_ product: Product?) {
        guard let product = product else { return }
        let detailVC = self.instantiateViewController(fromStoryboard: .main, ofType: DetailVC.self)
        detailVC.selectedItem = product
        detailVC.searchList = searchResult
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - CALL API
    
    private func searchItemWithParam(query: String) {
        let param = ["channel": "pv_online", "visitorId": "", "q": query, "terminal": "CP01"]
        showLoading()
        APIService.searchItem(param).subscribe(onNext: { [weak self] response in
            guard let weakSelf = self else { return }
            self?.dismissLoading()
            if response.code == ApiCode.success.rawValue {
                if let productsDict = response.data["products"] as? [[String: Any]] {
                    weakSelf.searchResult = productsDict.map({Product(JSON($0))})
                }
                self?.tableView.reloadData()
            } else {
                CustomDialog.shared().showSimpleAlert(message: "Có lỗi xảy ra", currentVC: weakSelf)
            }
        }).disposed(by: disposeBag)
    }

}

// MARK: - TEXT VIEW DELEGATE

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        searchItemWithParam(query: textField.text ?? "")
        return true
    }
    
}

// MARK: - TABLE VIEW DATA SOURCE

extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchItemCell = tableView.dequeueReusableCell(ofType: SearchItemCell.self, for: indexPath)
        let item = searchResult[safe: indexPath.row]
        searchItemCell?.fillData(item: item)
        return searchItemCell ?? UITableViewCell()
    }
    
}

// MARK: - TABLE VIEW DELEGATE

extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetailProduct(searchResult[safe: indexPath.row])
    }
}
