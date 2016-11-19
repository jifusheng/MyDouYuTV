//
//  PrettyCollectionCell.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class PrettyCollectionCell: BaseCollectionCell {

    // MARK: - 控件属性
    @IBOutlet weak private var cityBtn: UIButton!
    
    // MARK: - 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            guard let anchor = anchor else { return }
            cityBtn.setTitle(" \(anchor.anchor_city)", for: .normal)
        }
    }
}
