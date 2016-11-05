//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class AnchorModel: BaseGameModel {
   ///房间号
     var room_id : Int = 0
    ///房间图片对应的urlstring
     var vertical_src : String = ""
    ///判断是手机直播耗时电脑直播 0 表示电脑直播
     var isVertical : Int = 0
    ///房间名称
     var room_name : String = ""
    ///主播昵称
     var nickname : String = ""
    ///在线人数
     var online : Int = 0
    ///所在城市
    var anchor_city : String = ""
    
    
    
}
