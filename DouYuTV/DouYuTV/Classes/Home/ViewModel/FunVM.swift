//
//  FunVM.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/22.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  趣玩的viewModel

import UIKit

class FunVM: BaseViewModel {

}

extension FunVM {
    func loadAllFunData(completionHandler: @escaping () -> ()) {
        loadAnchorData(urlString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom", parameters: ["identification" : "393b245e8046605f6f881d415949494c"], completionHandler: completionHandler)
    }
}
