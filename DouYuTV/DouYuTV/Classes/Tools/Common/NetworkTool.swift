//
//  NetworkTool.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit
import Alamofire

enum HttpMethodType {
    case get
    case post
}

class NetworkTool {
    class func requestData(urlString: String,
                           type: HttpMethodType,
                           parameters: [String : Any]? = nil,
                           completionHandler: @escaping (_ result : Any) -> Void)
    {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print("请求失败\(response.result.error)")
                return
            }
            completionHandler(result)
        }
    }
}
