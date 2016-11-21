//
//  GameViewController.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  游戏

import UIKit


class GameViewController: HomeBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1、请求数据
        loadAllGameData()
    }
}

// MARK: - 请求数据
extension GameViewController {
    fileprivate func loadAllGameData() {
        gameVm.loadAllGameData { [weak self] in
            //1、刷新数据
            self?.collectionView.reloadData()
            //2、给cateView传递数据
            self?.cateView.games = self?.gameVm.games
        }
    }
}

