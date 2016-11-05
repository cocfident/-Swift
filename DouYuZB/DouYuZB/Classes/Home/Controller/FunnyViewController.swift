//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit


private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {

    fileprivate lazy var funnyVM : FunnyViewModel  = FunnyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

//MARK:- setUI
extension FunnyViewController{
    
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
 
}

extension FunnyViewController{
    override func loadData() {
        
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.loadDataFinished()
            self.collectionView.reloadData()
        }
        
    }
}
