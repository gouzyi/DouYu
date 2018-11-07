//
//  MainTabBarController.swift
//  DouYu
//
//  Created by gzy on 2018/10/11.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.orange
        addChild(vc)
    }

}
