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
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        configTableView()
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
        tableView.register(UINib(nibName: ItemInfoCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ItemInfoCell.identifier)
        tableView.estimatedRowHeight = 462
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fillData() {
        headerLabel.text = selectedItem.name
        headerPriceLabel.text = Utils.toCurrencyFormat(selectedItem.price.sellPrice)
    }
    
}

extension DetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return setupItemInfoCell(indexPath: indexPath)
    }
    
    private func setupItemInfoCell(indexPath: IndexPath) -> UITableViewCell {
        let itemInfoCell = tableView.dequeueReusableCell(ofType: ItemInfoCell.self, for: indexPath)
        itemInfoCell?.fillData(item: selectedItem)
        return itemInfoCell ?? UITableViewCell()
    }
    
}
