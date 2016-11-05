//
//  CollectionBaseCell.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var onLineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    //MARK:-数据模型
    var anchor : AnchorModel?{
        didSet{
            guard let anchor = anchor else {return}
            
            var onlinestr : String = ""
            
            if anchor.online >= 10000 {
                onlinestr = "\(Int(anchor.online/10000))万在线"
            }else{
                onlinestr = "\(anchor.online)在线"
            }
            
            onLineBtn.setTitle(onlinestr, for: .normal)
            nickName.text = anchor.nickname
            
            let iconURL = URL(string: anchor.vertical_src)
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
            
        }
    }

    
    
}
