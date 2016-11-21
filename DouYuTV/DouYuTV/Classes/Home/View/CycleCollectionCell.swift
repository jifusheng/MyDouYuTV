//
//  CycleCollectionCell.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class CycleCollectionCell: UICollectionViewCell {
    // MARK: - 控件属性
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UIButton!
    
    // MARK: - 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            guard let cycleModel = cycleModel else { return }
            let url = URL(string: cycleModel.pic_url)
            imageView.kf.setImage(with: url, placeholder: UIImage(named : "默认banner图"), options: nil, progressBlock: nil, completionHandler: nil)
            titleLbl.setTitle(cycleModel.title, for: .normal)
        }
    }
}
