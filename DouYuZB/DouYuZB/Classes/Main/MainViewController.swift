//
//  MainViewController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }

}

//MARK:-设置UI
extension MainViewController{
    
    func setupUI(){
        
        //添加子控制器
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
    }
    
    private func addChildVC(storyName : String){
        
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }
    
    
}
