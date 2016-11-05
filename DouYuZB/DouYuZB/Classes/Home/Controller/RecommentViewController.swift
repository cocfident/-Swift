//
//  RecommentViewController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit


private let kItemMargin : CGFloat = 10
private let kItemW   = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH   = kItemW * 3 / 4
private let kPrettyItemH   = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kCycleViewH  = kScreenW * 3 / 8
private let kGameViewH : CGFloat  = 90

private let kPrettyCellID = "kPrettyCellID"
private let kHearderView = "kHearderView"


class RecommentViewController: BaseAnchorViewController {

    //MARK:- 属性
    
    //MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate  lazy var cycleView   : RecommendCycleView = {
                  let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
     fileprivate  lazy var gameView   : RecommendGameView = {
        
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        
        return gameView
    }()
    
    
}

//MARK:- 设置UI界面

extension RecommentViewController{
    
  override  func setupUI() {
    
    super.setupUI()
    
        //将cycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
       collectionView.register( UINib(nibName: "CollectionPrettyViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
    
    }
    
}

//MARK:- 请求数据
extension RecommentViewController{
   override  func loadData() {
    
       baseVM = recommendVM
        recommendVM.requestData {
            //请求推荐数据
            self.loadDataFinished()
            self.collectionView.reloadData()
          
            var groups = self.recommendVM.anchorGroups
            
             groups.removeFirst()
             groups.removeFirst()
            
            let moreGoup = AnchorGroup()
            moreGoup.tag_name = "更多"
            groups.append(moreGoup)
            
          self.gameView.groups = groups
            
            
        }
        //请求轮播图
        recommendVM.requestCycleData { 
            self.cycleView.cycleModels = self.recommendVM.cycleGroup
        }
        
        }
}


//MARK:- UICollectionViewDataSource
extension RecommentViewController : UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        if indexPath.section == 1 {
            let  cell =  collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyViewCell
            let group = recommendVM.anchorGroups[indexPath.section]
            let anchor = group.anchors[indexPath.item]
             cell.anchor = anchor
            
            return cell
           
        }else{
            return  super.collectionView(collectionView, cellForItemAt: indexPath)
            
        }
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        if indexPath.section == 1 {
            
            return CGSize(width: kItemW, height: kPrettyItemH)
            
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
        
        
    }
    
    
}













