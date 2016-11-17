//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/10/20.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - 懒加载属性
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationH, width: kScreenW, height: 40)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    // MARK: - 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //0、设置不需要系统自动调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //1、设置UI界面
        setupUI()
        //2、添加titleView
        view.addSubview(pageTitleView)
    }


}

// MARK: - 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        //设置导航栏
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        //设置背景图片
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Img_orange"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        //设置左边的item
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "homeLogoIcon", edgeInsets: .init(top: 0, left: -10, bottom: 0, right: 10))
        //设置右边边的item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highlightedImage: "viewHistoryIconHL", size: size, edgeInsets: .init(top: 0, left: 10, bottom: 0, right: -10))
        let qrcodeItem = UIBarButtonItem(imageName: "scanIcon", highlightedImage: "scanIconHL", size: size, edgeInsets: .init(top: 0, left: 10, bottom: 0, right: -10))
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highlightedImage: "searchBtnIconHL", size: size, edgeInsets: .init(top: 0, left: 10, bottom: 0, right: -10))
        navigationItem.rightBarButtonItems = [searchItem, qrcodeItem, historyItem]
    }
}
