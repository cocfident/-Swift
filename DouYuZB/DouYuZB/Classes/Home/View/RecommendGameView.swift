//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

private let GameViewCellId = "GameViewCellId"

class RecommendGameView: UIView {

    var groups : [BaseGameModel]?{
        didSet{
            
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []

        collectionView.register(UINib(nibName: "CollectionVGameCell", bundle: nil), forCellWithReuseIdentifier: GameViewCellId)
        
    }

   
}
//MARK:- 快速创建的类方法
extension RecommendGameView{
    
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }


}

extension RecommendGameView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = groups![indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameViewCellId, for: indexPath) as! CollectionVGameCell
        
        cell.group = group
        
        return cell
    }
    
    
}











