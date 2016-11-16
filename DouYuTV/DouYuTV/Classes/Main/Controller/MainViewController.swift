//
//  MainViewController.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/10/20.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1、添加首页控制器
        addChildVc(storyName: "Home")
        
        //2、添加直播控制器
        addChildVc(storyName: "Live")
        
        //3、添加关注控制器
        addChildVc(storyName: "Follow")
        
        //4、添加我的控制器
        addChildVc(storyName: "Profile")
        
    }
    
    
    private func addChildVc(storyName : String) {
        //1、通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        //2、把控制器添加为子控制器
        addChildViewController(childVc)
    }

}
