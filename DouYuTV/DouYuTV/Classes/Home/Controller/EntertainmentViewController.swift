//
//  EntertainmentViewController.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  娱乐

import UIKit

class EntertainmentViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //加载娱乐数据
        loadAllEntertainmentData()
    }
}

extension EntertainmentViewController {
    // Mark - 加载数据
    func loadAllEntertainmentData() {
        gameVm.loadAllEntertainmentData { [weak self] in
            //1、处理数据（如果room_list没有数据就删除）
            for (index, gameModel) in (self?.gameVm.games.enumerated())! {
                if gameModel.anchors.count == 0 {
                    self?.gameVm.games.remove(at: index)
                }
            }
            //2、刷新数据
            self?.collectionView.reloadData()
            //3、给cateView传递数据
            self?.cateView.games = self?.gameVm.games
        }
    }
}
