//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW   = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH   = kItemW * 3 / 4
private let kPrettyItemH   = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHearderView = "kHearderView"


class BaseAnchorViewController: BaseViewController {

    //MARK:- 懒加载
     var baseVM : BaseViewModel!
    
     lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin , bottom: 0, right: kItemMargin)
        
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register( UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        //注册头
        collectionView.register(UINib(nibName: "CollectionHearderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHearderView)
        
        
        
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
        
        loadData()
        
        
    }

   
}

//MARK:- setUI
extension BaseAnchorViewController{
    
     override func setupUI(){
        
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
       
    }
    
     func loadData(){
        
    }

    
    
}


 //MARK:- UICollectionViewDelegate UICollectionViewDataSource

extension BaseAnchorViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHearderView, for: indexPath) as! CollectionHearderView
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        anchor.isVertical == 0 ? pushGameRoom() : presentShowRoom()
        
        
    }
    
    
    private func presentShowRoom(){
        let show = RoomShowViewController()
        
        self.present(show, animated: true, completion: nil)
    }
    
    private func pushGameRoom(){
        let game = RoomGameViewController()
        self.navigationController?.pushViewController(game, animated: true)
    }
    
}









