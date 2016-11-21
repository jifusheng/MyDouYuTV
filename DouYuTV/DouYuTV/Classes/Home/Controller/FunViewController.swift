//
//  FunViewController.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  趣玩

import UIKit

class FunViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //加载趣玩数据
        loadAllFunData()
    }
}

// Mark - 加载数据
extension FunViewController {
    // Mark - 加载趣玩数据
    func loadAllFunData() {
        gameVm.loadAllfunData { [weak self] in
            //1、刷新数据
            self?.collectionView.reloadData()
            //2、给cateView传递数据
            self?.cateView.games = self?.gameVm.games
        }
    }
}
