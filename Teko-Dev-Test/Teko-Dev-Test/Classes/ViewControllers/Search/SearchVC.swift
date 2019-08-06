//
//  SearchVC.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import RxSwift

class SearchVC: BaseVC {
    
    @IBOutlet weak var containerSearchView: UIView!
    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configSearchView()
    }
    
    // MARK: FUNCTIONS
    
    func configSearchView() {
        // set height for container search view
        let subSearchViewHeight: CGFloat = 48
        searchViewHeight.constant = UIScreen.statusBarHeight + subSearchViewHeight
        
        // set gradient for container view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = containerSearchView.bounds
        gradientLayer.colors =  [UIColor(red: 223, green: 32, blue: 32).cgColor, UIColor(red: 245, green: 71, blue: 30).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        containerSearchView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func searchItemWithParam() {
        let param = ["channel": "pv_online", "visitorId": "", "q": "", "terminal": "CP01"]
        APIService.searchItem(param).subscribe(onNext: { [weak self] response in
            print("resulttttt")
        }).disposed(by: disposeBag)
    }

}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
}
