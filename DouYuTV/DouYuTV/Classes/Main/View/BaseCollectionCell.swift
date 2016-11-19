//
//  BaseCollectionCell.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/19.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    // MARK: - 控件属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nikeNameBtn: UIButton!
    @IBOutlet weak var onlineCountBtn: UIButton!
    
    // MARK: - 定义模型属性
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            let url = URL(string: anchor.vertical_src)
            iconView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
            nikeNameBtn.setTitle(" \(anchor.nickname)", for: .normal)
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = String(format:"%.1f万",Double(anchor.online) / 10000.0)
            } else {
                onlineStr = " \( anchor.online)"
            }
            onlineCountBtn.setTitle(onlineStr, for: .normal)
        }
    }
}
