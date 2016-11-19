//
//  RecommendHeaderView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class RecommendHeaderView: UICollectionReusableView {
    
    // MARK: - 控件属性
    @IBOutlet weak fileprivate var logoView: UIImageView!
    @IBOutlet weak fileprivate var headerTitle: UILabel!
    
    // MARK: - 按钮的点击
    @IBAction func moreBtn() {

    }
    
    // MARK: - 定义模型属性
    var anchorGroup : AnchorGroupModel? {
        didSet {
            logoView.image = UIImage(named: anchorGroup?.icon_name ?? "home_header_phone")
            headerTitle.text = anchorGroup?.tag_name
        }
    }
    
}
