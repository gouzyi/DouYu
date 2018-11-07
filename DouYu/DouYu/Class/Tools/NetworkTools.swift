//
//  NetworkTools.swift
//  DouYu
//
//  Created by gzy on 2018/10/22.
//  Copyright © 2018 gzy. All rights reserved.
//

import Alamofire



enum MethodType {
    case Get
    case Post
}


class NetworkTools {
    
    class func requestData(URLString: String, type: MethodType, parameters: [String : Any]? = nil, finishCallback: @escaping (_ result: Any)->()) {
        
        let method = type == .Get ? HTTPMethod.get:HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 1.校验是否有结果
            /*
             if let result = response.result.value {
             finishedCallback(result)
             } else  {
             print(response.result.error)
             }
             */
            
            //1. 校验是否有结果
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            //2. 将结果返回
            finishCallback(result)
        }
        
    }
}
