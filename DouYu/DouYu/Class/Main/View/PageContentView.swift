//
//  PageContentView.swift
//  DouYu
//
//  Created by gzy on 2018/10/15.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit


protocol PageContentViewDelegate : class{
    func pageContentView(ontentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let CellID = "CellID"
class PageContentView: UIView {

    private var childControllers: [UIViewController]
    private weak var parentController: UIViewController?
    private var startOffsetX: CGFloat = 0
    weak var delegate: PageContentViewDelegate?
    private var isForbidScrollViewDelegate: Bool = false

    
    private lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.frame = bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellID)
        return collectionView
    }()

    // 自定义构造函数
     init(frame: CGRect, childControllers: [UIViewController], parentController: UIViewController?) {
        self.childControllers = childControllers
        self.parentController = parentController
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView {
    private func setupUI() {
        for childController in self.childControllers {
            parentController?.addChild(childController)
        }
        addSubview(self.collectionView)
        
    }
}

//MARK: - UICollectionViewDataSource

extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath)
        for view  in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childControllers[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollViewDelegate = false
        startOffsetX = scrollView.contentOffset.x
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollViewDelegate {
            return
        }
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        // 判断h左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width

        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childControllers.count {
                targetIndex = childControllers.count - 1
            }
            // 如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else {
            
            progress = 1 -  currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childControllers.count {
                sourceIndex = childControllers.count - 1
            }
        }
        
        delegate?.pageContentView(ontentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK: - 对外暴露的方法
extension PageContentView {
    
    func setCurrentIndex(currentIndex: Int) {
        isForbidScrollViewDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}
