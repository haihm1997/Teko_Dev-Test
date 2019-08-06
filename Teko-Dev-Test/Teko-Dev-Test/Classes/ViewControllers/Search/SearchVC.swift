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
    
//    let searchResult: [SearchItem] = [SearchItem(id: "1", thumbnailUrl: "ic_monitor", name: "Màn hình LCD HKC 31.5 M32A7Q", price: "8.790.000"),
//                                      SearchItem(id: "2", thumbnailUrl: "ic_monitor", name: "Thẻ nhớ SDHC Sandisk 16GB Extre me Pro (class 10) Ultra Thẻ nhớ SDHC Sandisk 16GB Extre me Pro (class 10) Ultra",
//                                                 price: "6.000.000", discount: "2.000.000", discountPercent: 10),
//                                      SearchItem(id: "1", thumbnailUrl: "ic_monitor", name: "Màn hình LCD HKC 31.5", price: "8.790.000"),
//                                      SearchItem(id: "2", thumbnailUrl: "ic_monitor", name: "Thẻ nhớ SDHC Sandisk 16GB Extre me Pro (class 10) Ultra",
//                                                 price: "6.000.000", discount: "2.000.000", discountPercent: 10),
//                                      SearchItem(id: "2", thumbnailUrl: "ic_monitor", name: "Thẻ nhớ SDHC Sandisk 16GB Extre me Pro (class 10) Ultra",
//                                                 price: "6.000.000", discount: "2.000.000", discountPercent: 10),
//                                      SearchItem(id: "1", thumbnailUrl: "ic_monitor", name: "Màn hình LCD HKC 31.5", price: "800.000"),
//                                      SearchItem(id: "1", thumbnailUrl: "ic_monitor", name: "Màn hình LCD HKC 31.5", price: "8.790.000"),
//                                      SearchItem(id: "2", thumbnailUrl: "ic_monitor", name: "Thẻ nhớ SDHC Sandisk 16GB Extre me Pro (class 10) Ultra",
//                                                 price: "6.000.000", discount: "2.000.000", discountPercent: 10),
//                                      SearchItem(id: "2", thumbnailUrl: "ic_monitor", name: "Thẻ nhớ SDHC Sandisk 16GB Extre me Pro (class 10) Ultra",
//                                                 price: "6.000.000", discount: "2.000.000", discountPercent: 10),
//                                      SearchItem(id: "1", thumbnailUrl: "ic_monitor", name: "Màn hình LCD HKC 31.5", price: "8.790.000"),
//                                      SearchItem(id: "2", thumbnailUrl: "ic_monitor", name: "Thẻ nhớ SDHC Sandisk 16GB Extre me Pro (class 10) Ultra",
//                                                 price: "6.000.000", discount: "200.000", discountPercent: 10),
//                                      SearchItem(id: "2", thumbnailUrl: "ic_monitor", name: "Thẻ nhớ SDHC Sandisk 16GB Extre me Pro (class 10) Ultra",
//                                                 price: "6.000.000", discount: "2.000.000", discountPercent: 10)
//                                     ]
    var searchResult: [SearchItem] = [SearchItem]()
    
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        configTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configSearchView()
    }
    
    // MARK: FUNCTIONS
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SearchItemCell.identifier, bundle: nil),
                           forCellReuseIdentifier: SearchItemCell.identifier)
        tableView.isEmptyRowsHidden = true
        tableView.rowHeight = 110
    }
    
    private func configSearchView() {
        // set height for container search view
        let subSearchViewHeight: CGFloat = 48
        searchViewHeight.constant = UIScreen.statusBarHeight + subSearchViewHeight
        
        // set gradient for container view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = containerSearchView.bounds
        gradientLayer.colors =  [Constants.Color.tomatoTwo.cgColor, Constants.Color.reddishOrange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        containerSearchView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    fileprivate func searchItemWithParam(query: String) {
        let param = ["channel": "pv_online", "visitorId": "", "q": query, "terminal": "CP01"]
        showLoading()
        APIService.searchItem(param).subscribe(onNext: { [weak self] response in
            self?.dismissLoading()
            if let productsDict = response.data["products"] as? [[String: Any]] {
                self?.searchResult = productsDict.map({SearchItem(JSON($0))})
            }
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        searchItemWithParam(query: textField.text ?? "")
        return true
    }
    
}

extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchItemCell = tableView.dequeueReusableCell(ofType: SearchItemCell.self, for: indexPath)
        let item = searchResult[safe: indexPath.row]
        searchItemCell?.fillData(item: item ?? SearchItem())
        return searchItemCell ?? UITableViewCell()
    }
    
}

extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
