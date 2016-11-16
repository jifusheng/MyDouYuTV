//
//  UIBarButtonItem-Extension.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/10/20.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
//    class func createItem(imageName: String, highlightedImage: String, size: CGSize) ->UIBarButtonItem {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highlightedImage), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        if size.equalTo(CGSize.zero) {
//            btn.sizeToFit()
//        }
//        return UIBarButtonItem(customView: btn)
//    }
    
    convenience init(imageName: String, highlightedImage: String = "", size: CGSize = CGSize.zero, edgeInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highlightedImage != "" {
            btn.setImage(UIImage(named: highlightedImage), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        if edgeInsets != UIEdgeInsetsMake(0, 0, 0, 0) {
            btn.contentEdgeInsets = edgeInsets
        }
        self.init(customView: btn)
    }
}
