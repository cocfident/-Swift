//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class BaseViewModel{

    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()


}

extension BaseViewModel{
    
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil,finishedCallback : @escaping () -> ()){
        
        
        NetworkTools.requestData(type: .GET, URLString: URLString, parameters: parameters as! [String : NSString]?) { (result) in
            
            // 1.获取数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            if isGroupData {
                
                // 2.字典转模型
                for dict in dataArray {
                    
                    if (dict["room_list"] as AnyObject).count == 0 { continue }
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                    
                }

            }else{
                
                let group = AnchorGroup()
                
                for dict in dataArray {
                    
                   group.anchors.append(AnchorModel(dict: dict))
                    
                }
                
                self.anchorGroups.append(group)

            }
            
            finishedCallback()
            
        }

    }
    
    
}
