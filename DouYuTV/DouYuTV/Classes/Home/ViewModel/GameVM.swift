//
//  GameVM.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class GameVM {
    //定义属性
    var games : [GameModel] = [GameModel]()
}

// MARK: - 请求所以游戏数据
extension GameVM {
    // MARK: - 请求游戏界面的数据
    func loadAllGameData(completionHandler: @escaping () -> Void) {
        NetworkTool.requestData(urlString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom", type: .get, parameters: ["identification" : "ba08216f13dd1742157412386eee1225"]) { (result) in
            //获取字典数据
            guard let result = result as? [String : Any] else { return }
            //获取字典中对应key的数据 - 数组
            guard let dataArray = result["data"] as? [[String : Any]] else { return }
            //字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            completionHandler()
        }
    }
}



