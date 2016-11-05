//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    //MARK:-控件属性
 
    @IBOutlet weak var roomName: UILabel!
    
     //MARK:-数据模型
  override  var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            roomName.text = anchor?.room_name
        }
    }
    
    
   
}
