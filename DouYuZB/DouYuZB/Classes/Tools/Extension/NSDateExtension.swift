//
//  NSDateExtension.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import Foundation

extension NSDate{
    
    class func getCurrentTime() -> String{
        
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        
        return "\(interval)"
    }
    
}
