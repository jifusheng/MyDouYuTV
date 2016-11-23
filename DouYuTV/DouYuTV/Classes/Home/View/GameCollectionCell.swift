//
//  GameCollectionCell.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class GameCollectionCell: UICollectionViewCell {

    var baseModel : BaseGroupModel? {
        didSet {
            guard let baseModel = baseModel else { return }
            let url = URL(string: baseModel.icon_url)
            iconView.kf.setImage(with: url, placeholder: UIImage(named: placeholderImageName!))
            nameLbl.text = baseModel.tag_name
        }
    }
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    var placeholderImageName : String? = "home_more_btn"
}
