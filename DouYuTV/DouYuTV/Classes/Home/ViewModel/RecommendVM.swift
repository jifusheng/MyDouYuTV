//
//  RecommendVM.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class RecommendVM : BaseViewModel {
    // MARK: - 懒加载属性
    fileprivate lazy var normalGroup : AnchorGroupModel = AnchorGroupModel()
    fileprivate lazy var prettyGroup : AnchorGroupModel = AnchorGroupModel()
    
    lazy var cycleModels : [CycleModel] = [CycleModel]()
}

// MARK: - 发送网络请求
extension RecommendVM {
    // MARK: - 请求推荐数据
    func loadRecommendData(completionHandler:@escaping () -> Void) {
        //0、定义参数
        let parameters : [String : Any] = ["limit" : 4,
                          "offset" : 0,
                          "time" : NSDate.getCurrentTime()]
        //1、创建队列组
        let dispatchGroup = DispatchGroup()
        
        //2、请求第一部分的推荐数据
        //进入组
        dispatchGroup.enter()
        NetworkTool.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .get, parameters: parameters) { (result) in
            //1、把result转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            //2、根据key->data取出值
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            //3、创建组模型
            self.normalGroup.tag_name = "最热"
            self.normalGroup.icon_name = "home_header_hot"
            //4、遍历数组取出字典后转成模型对象
            for dict : [String : Any] in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.normalGroup.anchors.append(anchor)
            }
            //5、离开组
            dispatchGroup.leave()
        }
        //3、请求第二部分的颜值数据
        //进入组
        dispatchGroup.enter()
        NetworkTool.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parameters: parameters) { (result) in
            //1、把result转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            //2、根据key->data取出值
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            //3、创建组模型
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //4、遍历数组取出字典后转成模型对象
            for dict : [String : Any] in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //5、离开组
            dispatchGroup.leave()
        }
        //4、请求第三部分(2-12组)的游戏数据
        //进入组
        dispatchGroup.enter()
        loadAnchorData(urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            //离开组
            dispatchGroup.leave()
        }
        //5、所以数据全部请求完成后排序
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.normalGroup, at: 0)
            completionHandler()
        }
    }
    
    // MARK: - 请求图片轮播数据
    func loadCycleData(completionHandler: @escaping () -> Void) {
        NetworkTool.requestData(urlString: "http://www.douyutv.com/api/v1/slide/6", type: .get, parameters: ["version" : "2.300"]) { (result) in
            //获取字典数据
            guard let result = result as? [String : Any] else { return }
            //获取字典中对应key的数据 - 数组
            guard let dataArray = result["data"] as? [[String : Any]] else { return }
            //字典转模型
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            completionHandler()
        }
    }
}




