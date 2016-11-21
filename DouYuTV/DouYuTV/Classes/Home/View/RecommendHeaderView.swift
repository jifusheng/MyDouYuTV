//
//  RecommendHeaderView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  推荐每组的headerView

import UIKit

class RecommendHeaderView: UICollectionReusableView {
    
    // MARK: - 控件属性
    @IBOutlet weak fileprivate var logoView: UIImageView!
    @IBOutlet weak fileprivate var headerTitle: UILabel!
    
    // MARK: - 按钮的点击
    @IBAction func moreBtn() {

    }
    
    // MARK: - 定义模型属性
    var baseGroup : BaseGroupModel? {
        didSet {
            logoView.image = UIImage(named: baseGroup?.icon_name ?? "home_header_phone")
            headerTitle.text = baseGroup?.tag_name
        }
    }
    
}
