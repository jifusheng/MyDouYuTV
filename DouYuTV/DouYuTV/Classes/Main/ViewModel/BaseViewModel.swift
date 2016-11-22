//
//  BaseViewModel.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/22.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class BaseViewModel {
    // MARK: - 懒加载属性
    lazy var anchorGroups : [BaseGroupModel] = [BaseGroupModel]()
}

extension BaseViewModel {
    func loadAnchorData(urlString: String, parameters: [String : Any]? = nil, completionHandler: @escaping () -> ()) {
        NetworkTool.requestData(urlString: urlString, type: .get, parameters: parameters) { (result) in
            //获取字典数据
            guard let result = result as? [String : Any] else { return }
            //获取字典中对应key的数据 - 数组
            guard let dataArray = result["data"] as? [[String : Any]] else { return }
            //字典转模型
            for dict in dataArray {
                self.anchorGroups.append(BaseGroupModel(dict: dict))
            }
            completionHandler()
        }
    }
}
