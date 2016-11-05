//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
   
    
    convenience init(imageName : String, highImageName : String = "", size : CGSize  = CGSize.zero) {
      
        let btn = UIButton()
        
        btn.setImage(UIImage(named : imageName), for: .normal)
        if highImageName != "" {
            
             btn.setImage(UIImage(named : highImageName), for: .highlighted)
        }
       
        if size == CGSize.zero {
            btn.sizeToFit()
        } else{
            
            btn.frame = CGRect(origin: CGPoint.zero, size: size)

        }

        self.init(customView : btn)
        
    }
    
    
    
}
