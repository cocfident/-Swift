//
//  CustomNavController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class CustomNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //获取系统的pop收拾
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        //获取手势添加的view中
        guard let gesView = systemGes.view else {return}
      
        //获取target
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        
       guard let target = targetObjc .value(forKey: "target") else {return}
        let action = Selector(("handleNavigationTransition:"))
        
        //创建自己的手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
        
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
  
}
