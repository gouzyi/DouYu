//
//  Common.swift
//  DouYu
//
//  Created by gzy on 2018/10/14.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height
let isIphoneX = kScreenH >= 812 ? true:false


// 状态栏高度
let kStatusBarH: CGFloat = isIphoneX ? 44 : 20
// 导航栏高度
let kNavigationBarH : CGFloat = isIphoneX ? 88 : 64
// TabBar高度
let kTabBarH : CGFloat = isIphoneX ? 49 + 34 : 49



