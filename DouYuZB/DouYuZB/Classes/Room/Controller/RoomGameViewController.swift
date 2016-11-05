//
//  RoomGameViewController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class RoomGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         view.backgroundColor = UIColor.orange
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

}
