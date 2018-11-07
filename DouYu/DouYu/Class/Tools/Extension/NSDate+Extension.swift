//
//  NSDate+Extension.swift
//  DouYu
//
//  Created by gzy on 2018/10/23.
//  Copyright © 2018 gzy. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
