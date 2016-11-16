//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/10/20.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1、设置UI界面
        setupUI()
    }


}

// MARK: - 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        //设置导航栏
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        //设置左边的item
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo", edgeInsets: .init(top: 0, left: -10, bottom: 0, right: 10))
        //设置右边边的item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightedImage: "Image_my_history_click", size: size, edgeInsets: .init(top: 0, left: 10, bottom: 0, right: -10))
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightedImage: "Image_scan_click", size: size, edgeInsets: .init(top: 0, left: 10, bottom: 0, right: -10))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightedImage: "btn_search_clicked", size: size, edgeInsets: .init(top: 0, left: 10, bottom: 0, right: -10))
        navigationItem.rightBarButtonItems = [searchItem, qrcodeItem, historyItem]
    }
}
