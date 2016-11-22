//
//  GameVM.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class GameVM : BaseViewModel {
    
}

// MARK: - 请求所以游戏数据
extension GameVM {
    // MARK: - 请求游戏界面的数据
    func loadAllGameData(completionHandler: @escaping () -> Void) {
        loadAnchorData(urlString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom", parameters: ["identification" : "ba08216f13dd1742157412386eee1225"], completionHandler: completionHandler)
    }
}



