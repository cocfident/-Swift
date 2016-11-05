//
//  CycleModel.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    ///标题
    var title : String = ""
    ///展示图片
    var pic_url : String = ""
    ///主播信息对应的字典
    var room  : [String : AnyObject]?{
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    ///主播信息对应的模型
    var anchor : AnchorModel?
    
    //MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
