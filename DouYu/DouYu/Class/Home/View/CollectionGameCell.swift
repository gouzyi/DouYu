//
//  CollectionGameCell.swift
//  DouYu
//
//  Created by gzy on 2018/11/6.
//  Copyright © 2018 gzy. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    // MARK: 控件属性
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    var group: AnchorGroup? {
        didSet {
            
            titleLab.text = group?.tag_name
            if let iconURL = URL(string: group?.icon_url ?? "") {
                iconImgView.kf.setImage(with: iconURL)
            } else {
                iconImgView.image = UIImage(named: "home_more_btn")
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
