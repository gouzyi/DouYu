//
//  CollectionPrettyCell.swift
//  DouYu
//
//  Created by gzy on 2018/10/21.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit
class CollectionPrettyCell: UICollectionViewCell {
    
    //MARK: 控件属性
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var onlineLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    //MARK: 定义属性模型
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineLab.text = onlineStr
            titleLab.text = anchor.nickname
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            
            guard let iconURL = URL(string: anchor.vertical_src) else { return }

            imgView.kf.setImage(with: iconURL)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
