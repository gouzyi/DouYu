//
//  CycleMdoel.swift
//  DouYu
//
//  Created by gzy on 2018/11/6.
//  Copyright © 2018 gzy. All rights reserved.
//

import UIKit

class CycleMdoel: NSObject {

    @objc var title: String = ""
    @objc var pic_url: String = ""
    @objc var room: [String: Any]? {
        didSet {
            guard let room = room else {return}
            anchor = AnchorModel(dic: room)
        }
    }
    @objc var anchor: AnchorModel?
    // MARK:- 自定义构造函数
    init(dic: [String: Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
  
    
}
