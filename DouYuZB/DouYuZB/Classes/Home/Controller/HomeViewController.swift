//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit


private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    //MARK:-懒加载
    lazy var pageTitleView : PageTitleView = {[weak self] in
        
        let titleViewFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩",]
        let titleView = PageTitleView(frame: titleViewFrame, titles: titles)
           titleView.delegate = self
        return titleView
    }()
    lazy var pageContentView : PageContentVeiw = { [weak self] in
        
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVCs = [UIViewController]()
        var recommentVC = RecommentViewController()
        
        childVCs.append(recommentVC)
        
        var gameVC = GameViewController()
        childVCs.append(gameVC)
        
        var amuseVC = AmuseViewController()
        childVCs.append(amuseVC)
        
        var funnyVC = FunnyViewController()
        childVCs.append(funnyVC)
            
        
        let contentView  = PageContentVeiw(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        
        contentView.delegate = self
        
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        //设置UI界面
        setupUI()
        
     
        
    }

   
}
//MARK:- 设置UI界面
extension HomeViewController{
    
    func setupUI(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        //添加titleView
        view.addSubview(pageTitleView)
        //添加contentView
        view.addSubview(pageContentView)
        
    }
    //设置导航栏
    private func setupNavigationBar(){
        
        //设置左边的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")

        //设置右边的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem  = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let scanItem    = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
        
        
    }
    
}
//MARK:- PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        
      pageContentView.setCurrentIndex(currentIndex: selectedIndex)
        
    }
}

extension HomeViewController : PageContentVeiwDelegate{
    
    func pageContentView(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
       pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}










