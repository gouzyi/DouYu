//
//  RecommendViewModel.swift
//  DouYu
//
//  Created by gzy on 2018/10/23.
//  Copyright © 2018 gzy. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels: [CycleMdoel] = [CycleMdoel]()
    
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
    
    
}
// MARK: 发送网络请求
extension RecommendViewModel {
    //MARK: 请求首页数据
    func requestData(finishCallBack: @escaping ()->()) {
        
        let paramerts = ["limit": "4", "offset": "0", "time": NSDate.getCurrentTime()]
        let group = DispatchGroup()
        group.enter()
        // 1. 请求推荐
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .Get, parameters: ["time": NSDate.getCurrentTime()]) { (result) in
            
            guard let resultDic = result as? [String: Any] else {return}
            guard let dataArr = resultDic["data"] as? [[String: Any]] else {return}
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dic in dataArr {
                let anchor = AnchorModel(dic: dic)
                self.bigDataGroup.anchors.append(anchor)
            }
            group.leave()
            print("请求第0组数据")
        }
        
        group.enter()
        // 2. 请求颜值
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .Get, parameters: paramerts) { (result) in
            guard let resultDic = result as? [String: Any] else {return}
            guard let dataArr = resultDic["data"] as? [[String: Any]] else {return}
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dic in dataArr {
                let anchor = AnchorModel(dic: dic)
                self.prettyGroup.anchors.append(anchor)
            }
            
            group.leave()
            print("请求第1组数据")
        }
        // 3. 后面的数据
//        print(NSDate.getCurrentTime())
        group.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", type: .Get, parameters: paramerts ) { (result) in
            guard let resultDic = result as? [String: Any] else {return}
            guard let dataArr = resultDic["data"] as? [[String: Any]] else {return}
            for dic in dataArr {
                let group = AnchorGroup(dic: dic)
                self.anchorGroups.append(group)
            }
            group.leave()
            print("请求2-12数据")
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("所有的数据")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }
    }
    //MARK: 请求无线轮播数据
    func requestCycleData(finishCallBack: @escaping ()->())  {
        
        NetworkTools.requestData(URLString: "http://www.douyutv.com/api/v1/slide/6", type: .Get, parameters: ["version": "2.300"]) { (result) in
            guard let resultDic = result as? [String: Any] else {return}
            guard let dataArr = resultDic["data"] as? [[String: Any]] else {return}
            
            for dic in dataArr {
                let model = CycleMdoel(dic: dic)
                self.cycleModels.append(model)
            }

            finishCallBack()
            
        }
        
    }

}
