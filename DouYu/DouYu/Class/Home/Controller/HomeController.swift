//
//  HomeController.swift
//  DouYu
//
//  Created by gzy on 2018/10/11.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40
class HomeController: UIViewController {
    
    // MARK: 懒加载
    private lazy var pageTitleView: PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = {[weak self] in
        
        let contentFrame = CGRect(x: 0, y: kNavigationBarH + kTitleViewH, width: kScreenW, height: kScreenH - kNavigationBarH - kTabBarH)
        var childControllers = [UIViewController]()
        let vc = RecommendController()
        childControllers.append(vc)
        for _  in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childControllers.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childControllers: childControllers, parentController: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false

        setupUI()
        view.addSubview(self.pageTitleView)
        view.addSubview(self.pageContentView)
    }
    
}
// MARK: -
extension HomeController {
    
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
   
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
    
    
}

// MARK: - PageTitleViewDelegate
extension HomeController: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeController: PageContentViewDelegate {
    func pageContentView(ontentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
