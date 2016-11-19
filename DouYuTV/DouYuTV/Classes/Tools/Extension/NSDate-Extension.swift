//
//  NSDate-Extension.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowData = NSDate()
        let interval = Int(nowData.timeIntervalSince1970)
        return "\(interval)"
    }
}
