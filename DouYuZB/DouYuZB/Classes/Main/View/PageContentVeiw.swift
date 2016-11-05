//
//  PageContentVeiw.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

protocol PageContentVeiwDelegate : class {
    func pageContentView(progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentVeiw: UIView {

    //MARK:-定义属性
    var childVCs : [UIViewController]
    weak var parentViewController : UIViewController?
    var startOffsetX : CGFloat = 0
    var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentVeiwDelegate?
    //MARK:-懒加载
    lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        
        return collectionView
    }()
    
    
    //MARK:-自定义构造函数
    init(frame: CGRect, childVCs : [UIViewController], parentViewController : UIViewController?) {
        
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:-设置UI
extension PageContentVeiw{
    
    func setupUI(){
        
        //将所有自控制器添加到父控制器中
        for childVc in childVCs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //添加UICollectionView 用于在cell 中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
        
    }
    
}

//MARK:遵守 UICollectionViewDataSource
extension PageContentVeiw : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVc = childVCs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
}

//MARK:-UICollectionViewDelegate
extension PageContentVeiw : UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        //获取需要的数据
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //判断是左滑还是右滑
        
        let currentOffsetX = scrollView.contentOffset.x
         let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
           progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //就算sourceIndex
            
            sourceIndex = Int(currentOffsetX / scrollViewW )
            
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            targetIndex = sourceIndex + 1
            
            //如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{//右滑
            
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //计算target

            targetIndex =  Int(currentOffsetX / scrollViewW )
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            
        }
        //将拿到的数据传递给titleView
        delegate?.pageContentView(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    
    
}
//MARK:-对外暴露的方法
extension PageContentVeiw{
    
    func setCurrentIndex(currentIndex : Int){
        
        //记录需要禁止执行代理方法
        isForbidScrollDelegate = true
        //滚到制定的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset( CGPoint(x: offsetX, y: 0), animated: false)
        
        
        
    }
}

































