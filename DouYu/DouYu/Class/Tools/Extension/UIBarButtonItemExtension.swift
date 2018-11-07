//
//  UIBarButtonItemExtension.swift
//  DouYu
//
//  Created by gzy on 2018/10/12.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    // 类方法
    class func createItem(imageName: String, highImageName: String, size: CGSize) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .selected)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    // 构造函数 便利构造函数
    // 1. convenience开头
    // 2. 在构造函数中必须调用一个设计的构造函数(self)
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if  highImageName != ""{
            btn.setImage(UIImage(named: highImageName), for: .selected)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
    
}
