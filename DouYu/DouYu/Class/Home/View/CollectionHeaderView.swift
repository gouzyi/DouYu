//
//  CollectionHeaderView.swift
//  DouYu
//
//  Created by gzy on 2018/10/21.
//  Copyright © 2018年 gzy. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    
    var group: AnchorGroup? {
        didSet{
            titleLab.text = group?.tag_name
            iconImgView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
