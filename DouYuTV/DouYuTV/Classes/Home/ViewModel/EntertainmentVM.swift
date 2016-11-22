//
//  EntertainmentVM.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/22.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  娱乐的viewModel

import UIKit

class EntertainmentVM: BaseViewModel {

}

extension EntertainmentVM {
    func loadAllEntertainmentData(completionHandler: @escaping () -> ()) {
        loadAnchorData(urlString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom", parameters: ["identification" : "9acf9c6f117a4c2d02de30294ec29da9"], completionHandler: completionHandler)
    }
}
