//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit


private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var amuseMenuView : AmuseMenuView = {
        
        let amuseMenuView = AmuseMenuView.amuseMenuView()
        
        amuseMenuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        
        
        
        return amuseMenuView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

   
}

//MARK:- setupUI
extension AmuseViewController{
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
    
}


//MARK:- 请求网络
extension AmuseViewController{
    
    
    override func loadData(){
        //给父类赋值
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            
             self.loadDataFinished()
            self.collectionView.reloadData()
            var  groups = self.amuseVM.anchorGroups
            groups.removeFirst()
            self.amuseMenuView.groups = groups
           
        }
    }
    
}











