//
//  AnchorModel.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  主播模型

import UIKit

class AnchorModel: NSObject {
    // MARK: - 主播信息模型
    //房间id
    var room_id : Int = 0
    //房间图片对应的地址
    var vertical_src : String = ""
    //判断主播所用的设备 0、电脑（Normal） 1、手机（Show）
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播名称
    var nickname : String = ""
    //游戏名称
    var game_name : String = ""
    //在线人数
    var online : Int = 0
    //城市
    var anchor_city : String = ""
    
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}


