//
//  CollectionHearderView.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class CollectionHearderView: UICollectionReusableView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headName: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : AnchorGroup?{
        didSet{
            headName.text = group?.tag_name
            imageView.image = UIImage(named: group?.icon_name ?? "home_header_phone")
        }
    }
    
    
    
}

extension CollectionHearderView{
    class func collectionHeaderView() -> CollectionHearderView{
        return Bundle.main.loadNibNamed("CollectionHearderView", owner: nil, options: nil)?.first as! CollectionHearderView
    }
}
