//
//  BaseGameModel.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    var tag_name : String = ""
    var pic_url  : String = ""
    var icon_url  : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    //MARK:-构造函数
    override  init() {
        
    }

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
