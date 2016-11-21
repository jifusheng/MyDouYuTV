//
//  BaseGroupModel.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class BaseGroupModel: BaseGameModel {
    //该组中对应的房间信息
    var room_list : [[String : Any]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    var icon_name : String = "home_header_normal"
    var tag_id : Int = 0
    
    //定义主播的模型对象数组
    var anchors : [AnchorModel] = [AnchorModel]()
}
