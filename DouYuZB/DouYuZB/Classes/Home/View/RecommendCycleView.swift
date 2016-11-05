//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit
private let kCycleViewID = "kCycleViewID"



class RecommendCycleView: UIView {
    
    var cycleModels : [CycleModel]?{
        didSet{
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0), section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            
            removeCycleTimer()
            addCycleTimer()
        }
    }
    var cycleTimer : Timer?
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()

        autoresizingMask = []
        
        //注册
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleViewID)
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView 的布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    
    }

}

//MARK:- 提供一个快速创建View 的类方法
extension RecommendCycleView{
    class func recommendCycleView()->RecommendCycleView{
        
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
        
        
    }
}
//MARK:- UICollectionViewDataSource
extension RecommendCycleView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleViewID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModel
        
        return cell
        
    }
    
}
//MARK:- UICollectionViewDelegate
extension RecommendCycleView : UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offsetx = scrollView.contentOffset.x
         pageControl.currentPage = Int(offsetx / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
    
}

//MARK:- 对定时器的操作方法
extension RecommendCycleView{
    func addCycleTimer(){
        
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(RecommendCycleView.scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    func removeCycleTimer(){
        
        cycleTimer?.invalidate()
        cycleTimer = nil
        
    }
    
    func scrollToNext(){
        
        let currentOffsetX = collectionView.contentOffset.x
        
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}








