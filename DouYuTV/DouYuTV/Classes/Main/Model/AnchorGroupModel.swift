//
//  AnchorGroupModel.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  主播组模型

import UIKit

class AnchorGroupModel: NSObject {
    //该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    var tag_name : String = ""
    var icon_url : String = ""
    var icon_name : String = "home_header_normal"
    var tag_id : Int = 0
    var push_vertical_screen : Int = 0
    
    //定义主播的模型对象数组
    var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}


