//
//  GameViewController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit


private let kEdageMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdageMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderH : CGFloat = 50
private let kGameViewH : CGFloat  = 90

private let kGemeHeaderID = "kGemeHeaderID"
private let GemeRecommandCellID = "gemeRecommandCellID"

class GameViewController: BaseViewController {

    //MARK:- 懒加载
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdageMargin, bottom: 0, right: kEdageMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionVGameCell", bundle: nil), forCellWithReuseIdentifier: GemeRecommandCellID)
        collectionView.register(UINib(nibName: "CollectionHearderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGemeHeaderID)
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
         collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    fileprivate lazy var topHeaderView  : CollectionHearderView = {
        let headerView = CollectionHearderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderH + kGameViewH), width: kScreenW, height: kHeaderH)
        headerView.headName.text = "常用"
        headerView.imageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true

        return headerView
    }()
    
    fileprivate  lazy var gameView   : RecommendGameView = {
        
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        
        return gameView
    }()

    
    
    
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
       loadData()

        
        
    }

   
}


//MARK:- setUI
extension GameViewController{
    
     override func setupUI(){
        
        contentView = collectionView
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kHeaderH + kGameViewH, left: 0, bottom: 0, right: 0)
        super.setupUI()
    }
    
    
}
//MARK:- 请求数据
extension GameViewController{
    
    fileprivate func loadData(){
       
        gameVM.loadAllGameData {
            self.loadDataFinished()
            self.collectionView.reloadData()
            self.gameView.groups = Array(self.gameVM.games[0..<10])
            
        }
        
 
    }
    
    
}

extension GameViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GemeRecommandCellID , for: indexPath) as! CollectionVGameCell
        
        cell.group = gameVM.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGemeHeaderID, for: indexPath) as! CollectionHearderView
       
        
        headerView.headName.text = "全部"
        headerView.imageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
        
    }

    
    
}







