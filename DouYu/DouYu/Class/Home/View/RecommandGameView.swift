//
//  RecommandGameView.swift
//  DouYu
//
//  Created by gzy on 2018/11/6.
//  Copyright © 2018 gzy. All rights reserved.
//

import UIKit

class RecommandGameView: UIView {
    //MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: String(describing: CollectionGameCell.self))
    }
}
// MARK:- 提供快速创建的类方法
extension RecommandGameView {
    class func recommendGameView() -> RecommandGameView {
        return Bundle.main.loadNibNamed("RecommandGameView", owner: nil, options: nil)?.first as! RecommandGameView
    }
}

extension RecommandGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionGameCell.self), for: indexPath) as! CollectionGameCell
        cell.group = groups?[indexPath.item]
        return cell
    }
}
