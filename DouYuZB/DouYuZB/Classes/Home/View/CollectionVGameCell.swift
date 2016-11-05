//
//  CollectionVGameCell.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionVGameCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    
    var group : BaseGameModel?{
        
        didSet{
            titleLabel.text = group?.tag_name
            let iconURL = URL(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
        
        }
    }
    

   

}
