//
//  AnchorModel.swift
//  DouYu
//
//  Created by gzy on 2018/10/28.
//  Copyright © 2018 gzy. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    @objc var room_id: Int = 0
    @objc var vertical_src: String = ""
    // 0: 电脑直播 1: 手机直播
    @objc var isVertical: Int = 0
    @objc var room_name: String = ""
    @objc var nickname: String = ""
    @objc var online: Int = 0
    // 所在城市
    @objc var anchor_city: String = ""
    
    init(dic: [ String: Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
