//
//  AnchorGroup.swift
//  DouYu
//
//  Created by gzy on 2018/10/28.
//  Copyright © 2018 gzy. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    @objc var tag_name: String?
    @objc var icon_name: String = "home_header_phone"
    @objc var icon_url: String = ""
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    @objc var room_list: [[String: Any]]? {
        didSet {
            guard let room_list = room_list else {return}
            for dic in room_list {
                anchors.append(AnchorModel(dic: dic))
            }
        }
    }
    


    
    init(dic: [String:Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    // MARK: 构造函数
    override init() {
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArr = value as? [[String: Any]] {
                for dic in dataArr {
                    anchors.append(AnchorModel(dic: dic))
                }
            }
        } */
    

    }
    

    
    
    
