//
//  GameCollectionCell.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class GameCollectionCell: UICollectionViewCell {

    var groupModel : AnchorGroupModel? {
        didSet {
            guard let groupModel = groupModel else { return }
            let url = URL(string: groupModel.icon_url)
            iconView.kf.setImage(with: url, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
            nameLbl.text = groupModel.tag_name
        }
    }
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!

}
