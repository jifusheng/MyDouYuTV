//
//  RecommendCycleView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/19.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  图片轮播视图

import UIKit

class RecommendCycleView: UIView {



}

// MARK: - 提供一个快速创建的方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)!.first as! RecommendCycleView
    }
}
