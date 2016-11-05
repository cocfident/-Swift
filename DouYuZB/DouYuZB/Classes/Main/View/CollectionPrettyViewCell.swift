//
//  CollectionPrettyViewCell.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyViewCell: CollectionBaseCell {
    
    
    //MARK:- 控件属性
    @IBOutlet weak var location: UIButton!
  
    //MARK:- 定义模型属性
   override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            location.setTitle(anchor?.anchor_city, for: .normal)
           
        }
    }
    
}

