//
//  AmuseMenuCell.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit


private let amuseMenuCellId = "amuseMenuCellId"


class AmuseMenuCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!

    var groups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       collectionView.register(UINib(nibName: "CollectionVGameCell", bundle: nil), forCellWithReuseIdentifier: amuseMenuCellId)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
         let kItemH : CGFloat = collectionView.bounds.height / 2
         let kItemW : CGFloat = collectionView.bounds.width / 4

        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        
    }

}


extension AmuseMenuCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: amuseMenuCellId, for: indexPath) as! CollectionVGameCell
        cell.bottomLine.isHidden = true
        cell.group = groups?[indexPath.item]
        return cell
    }

    
    
    
}
