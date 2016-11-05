//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
    
    

}

extension AmuseViewModel{
    
    
    func loadAmuseData(finishedCallback : @escaping () -> ())  {
        
       loadAnchorData(isGroupData: true,URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
        
    }
    
}
