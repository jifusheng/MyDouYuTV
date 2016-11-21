//
//  CycleModel.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  图片轮播模型

import UIKit

class CycleModel: NSObject {
    //id
    var id : Int = 0
    //标题
    var title : String = ""
    //图片地址
    var pic_url : String = ""
    //房间字典
    var room : [String : Any]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    //主播模型
    var anchor : AnchorModel?
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
