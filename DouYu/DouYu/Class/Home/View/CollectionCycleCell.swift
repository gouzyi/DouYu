//
//  CollectionCycleCell.swift
//  DouYu
//
//  Created by gzy on 2018/11/6.
//  Copyright © 2018 gzy. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    
    //MARK: 控件属性
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    var cycleModel: CycleMdoel? {
        didSet {
            titleLab.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            imgView.kf.setImage(with: iconURL)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
