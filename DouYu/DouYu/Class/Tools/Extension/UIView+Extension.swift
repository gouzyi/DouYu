//
//  UIView+Extension.swift
//  DouYu
//
//  Created by gzy on 2018/10/21.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
}
