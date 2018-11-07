//
//  CollectionNormalCell.swift
//  DouYu
//
//  Created by gzy on 2018/10/21.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {
    
    //MARK:  控件属性
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLab: UILabel!
    @IBOutlet weak var roomLab: UILabel!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else {return}
            var onlineStr: String = ""
            if anchor.online >= 1000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
                
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            guard let iconURL = URL(string: anchor.vertical_src) else {return}
            imgView.kf.setImage(with: iconURL)
            roomLab.text = anchor.room_name
            nickNameLab.text = anchor.nickname
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
