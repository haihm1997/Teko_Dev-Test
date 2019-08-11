//
//  SameTypeCell.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/10/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

class SameTypeCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "SameTypeCell"
    var itemList = [Product]()

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    // MARK: - FUNCTIONS
    
    func configCollectionView() {
        collectionView.register(UINib(nibName: SameTypeItemCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: SameTypeItemCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension SameTypeCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sameTypeCell = collectionView.dequeueReusableCell(ofType: SameTypeItemCell.self, for: indexPath)
        let item = itemList[safe: indexPath.row]
        sameTypeCell?.fillData(item: item)
        return sameTypeCell ?? UICollectionViewCell()
    }
    
}

extension SameTypeCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 220)
    }
    
}
