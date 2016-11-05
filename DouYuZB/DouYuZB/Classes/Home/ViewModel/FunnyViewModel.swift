//
//  FunnyViewModel.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/29.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel{

}

extension FunnyViewModel{
    
     func loadFunnyData(finishedCallback : @escaping () -> ()){
        
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters:["limit" : "30", "offset" : "0"], finishedCallback: finishedCallback)
        
    }
}
