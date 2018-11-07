//
//  PageTitleView.swift
//  DouYu
//
//  Created by gzy on 2018/10/14.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit

// MARK: - 定义协议
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}
// MARK: - 定义常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor: (CGFloat, CGFloat, CGFloat) = (255, 120, 0)

// MARK: - 定义PageTitleView
class PageTitleView: UIView {
    // 自定义属性
    private var titles: [String]
    private var titleLabs: [UILabel] = [UILabel]()
    private var currentIndex: Int = 0
    
    weak var delegate: PageTitleViewDelegate?
    
   private lazy var scrollView: UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.frame = bounds

        return scrollView
    }()
    
    lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setupUI() {
        addSubview(scrollView)
        setupTitleLabels()
        setupBottomMenuAndScrollLine()
    }
    private func setupTitleLabels() {
        
        let labW: CGFloat = frame.width / CGFloat(titles.count)
        let labH: CGFloat = frame.height - kScrollLineH
        let labY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let lab = UILabel()
            lab.text = title
            lab.tag = index
            lab.textAlignment = .center
            lab.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lab.font = UIFont.systemFont(ofSize: 16)
            
            let labX: CGFloat = labW * CGFloat(index)

            lab.frame = CGRect(x: labX, y: labY, width: labW, height: labH)
            scrollView.addSubview(lab)
            titleLabs.append(lab)
            
            lab.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabTapClick(_:)))
            lab.addGestureRecognizer(tapGes)
            
        }
    }
    private func setupBottomMenuAndScrollLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstLab = titleLabs.first else {
            return
        }
        scrollView.addSubview(scrollLine)
        firstLab.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollLine.frame = CGRect(x: firstLab.frame.origin.x, y: frame.height - kScrollLineH, width: firstLab.frame.width, height: kScrollLineH)
        
    }
    
}
// MARK: 监听label的点击事件
extension PageTitleView {
    @objc private func titleLabTapClick(_ tap: UITapGestureRecognizer) {
        guard let currentLab = tap.view as? UILabel else {
            return
        }
        if currentLab.tag == currentIndex {
            return
        }

        let oldLab = titleLabs[currentIndex]
        
        currentLab.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLab.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLab.tag

        // 滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) *  scrollLine.frame.width
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLab.tag)
        
    }
}
extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        let sourceLab = titleLabs[sourceIndex]
        let targetLab = titleLabs[targetIndex]
        // 处理滑块的逻辑
        let moveTotalX = targetLab.frame.origin.x - sourceLab.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLab.frame.origin.x + moveX
        
        // 滑块颜色渐变
        let colorDetal = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        
        sourceLab.textColor = UIColor(r: kSelectedColor.0 - colorDetal.0 * progress, g: kSelectedColor.1 - colorDetal.1 * progress, b: kSelectedColor.2 - colorDetal.2 * progress)
        
        targetLab.textColor = UIColor(r: kNormalColor.0 + colorDetal.0 * progress, g: kNormalColor.1 + colorDetal.1 * progress, b: kNormalColor.2 + colorDetal.2 * progress)
        
        currentIndex = targetIndex
        
    }
}
