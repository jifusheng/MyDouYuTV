//
//  NormalCollectionCell.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit
import Kingfisher

class NormalCollectionCell: BaseCollectionCell {

    // MARK: - 控件属性
    @IBOutlet weak private var roomNameLbl: UILabel!
    
    // MARK: - 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            guard let anchor = anchor else { return }
            roomNameLbl.text = " \(anchor.room_name)"
        }
    }
}
