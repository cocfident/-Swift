//
//  UIColor-Extension.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

extension UIColor{
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
        
    }
}
