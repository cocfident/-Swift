//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    fileprivate lazy var anmImageView : UIImageView = { [unowned self] in
        
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
            imageView.center = self.view.center
            imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        imageView.animationRepeatCount = LONG_MAX
        return imageView
    }()
    
    var contentView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
}

extension BaseViewController{
    
    func setupUI(){
        
        contentView?.isHidden = true
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        view.addSubview(anmImageView)
        anmImageView.startAnimating()
    }
    
    func loadDataFinished(){
        anmImageView.stopAnimating()
        anmImageView.isHidden = true
        contentView?.isHidden = false
    }
    
}

















