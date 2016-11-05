//
//  AmuseMenuView.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit


private let kMenuCellId = "kMenuCellId"


class AmuseMenuView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var groups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "AmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellId)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
}

extension AmuseMenuView {
    
    class func amuseMenuView() -> AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil { return 0}
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return  pageNum
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellId, for: indexPath) as! AmuseMenuCell
        
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / collectionView.bounds.width)
        
    }
    
    
    private func setupCellDataWithCell(cell : AmuseMenuCell, indexPath : IndexPath){
        
        //o页
        let startIndex = indexPath.item * 8
        var endIndex   = (indexPath.item + 1) * 8 - 1
        
        //判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        cell.groups = Array(groups![startIndex...endIndex])
        
        
    }
}




















