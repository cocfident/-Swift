//
//  CollectionCycleCell.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var cycleModel : CycleModel?{
        didSet{
            
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
             iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
