//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/28.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {

    //MARK:-懒加载
    lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    lazy var prettyGroup : AnchorGroup = AnchorGroup()
    lazy var cycleGroup  :  [CycleModel] = [CycleModel]()
}

//MARK:- 发送网络请求
extension RecommendViewModel{
    //请求推荐数据
    func requestData(finishedCallBack : @escaping ()->()) {
        
        let paramter = ["limit":"4","offset":"0","time": NSDate.getCurrentTime() as NSString]
        
        //创建group
        let DispatchG = DispatchGroup()
        
        DispatchG.enter()
        //请求推荐数据
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": NSDate.getCurrentTime() as NSString]) { (result) in
            
            //将result转成字典类型
            guard  let resultDict = result as? [String : AnyObject] else{return}
            //
            
            guard let dataArray = resultDict["data"] as? [[String : AnyObject]] else { return}
            
           
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                
                
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
                
            }
            
            DispatchG.leave()
            
        }

        
        
        
        //请求颜值数据
        DispatchG.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: paramter) { (result) in
            
            //将result转成字典类型
            guard  let resultDict = result as? [String : AnyObject] else{return}
            //
            guard let dataArray = resultDict["data"] as? [[String : AnyObject]] else { return}
            
           
             self.prettyGroup.tag_name = "颜值"
             self.prettyGroup.icon_name = "home_header_phone"
            
            
            for dict in dataArray {
               
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
                
            }

            DispatchG.leave()
            
        }
        
        //请求后面部分的游戏数据
         DispatchG.enter()
        
        loadAnchorData(isGroupData: true,URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: paramter) {
            
           DispatchG.leave()
        }
    
        //所有的数据都请求到 进行排序
        DispatchG.notify(queue: .main) { 
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallBack()
            
        }
        
}
    func requestCycleData(finishCallback : @escaping () -> ()){
        
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            
            //将result转成字典类型
            guard  let resultDict = result as? [String : AnyObject] else{return}
            //
            guard let dataArray = resultDict["data"] as? [[String : AnyObject]] else { return}
            
            for dict in dataArray {
               self.cycleGroup.append(CycleModel(dict: dict))
            }
            
            finishCallback()
            
        }
    }
    
    
    
    
}










