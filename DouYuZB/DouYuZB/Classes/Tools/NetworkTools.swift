//
//  NetworkTools.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit
import Alamofire


enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    
    class func requestData(type : MethodType,URLString : String, parameters : [String : NSString]? = nil, finishedCallback : @escaping (_ result : AnyObject)->()){
        
        //获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        
        //发送请求
       Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (respone) in
        
        guard let result = respone.result.value else {
            
            print("网络请求失败 --- \(respone.result.error)")
            return
        }
        
        finishedCallback(result as AnyObject)
        
        }
       
        
    }
    
}
