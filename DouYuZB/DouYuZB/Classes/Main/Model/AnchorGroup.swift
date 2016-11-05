//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {

    ///改组中对应的房间信息
    var room_list : [[String : AnyObject]]? {
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list {
                let anchor = AnchorModel(dict: dict)
                anchors.append(anchor)
            }
            
        }
    }
    var icon_name : String = "home_header_normal"
    
    ///定义主播的模型对象的数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    

}
