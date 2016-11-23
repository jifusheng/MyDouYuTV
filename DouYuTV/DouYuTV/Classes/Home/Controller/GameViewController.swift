//
//  GameViewController.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  游戏

import UIKit

private let kCateViewH : CGFloat = 190

class GameViewController: HomeBaseViewController {
    
    fileprivate lazy var gameVm : GameVM = GameVM()
    
    fileprivate lazy var cateView : RecommendCateView = {
        let cateView = RecommendCateView.recommendCateView()
        cateView.frame = CGRect(x: 0, y: -kCateViewH, width: kScreenW, height: kCateViewH)
        return cateView
    }()
}

extension GameViewController {
    override func setupUI() {
        super.setupUI()
        //1、把cateView添加到collectionView中
        collectionView.addSubview(cateView)
        //2、设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCateViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension GameViewController {
    override func loadData() {
        baseVm = gameVm
        gameVm.loadAllGameData { [weak self] in
            //1、给cateView传递数据
            self?.cateView.games = self?.gameVm.anchorGroups
            guard let baseVm = self?.baseVm else { return }
            if baseVm.anchorGroups.count > 15 {
                var cateArray : [BaseGroupModel] = [BaseGroupModel]()
                //从数组中取出15个数据
                for (index, gameM) in baseVm.anchorGroups.enumerated() {
                    if index < 15 {
                        cateArray.append(gameM)
                    }
                }
                baseVm.anchorGroups = cateArray
            }
            //2、刷新数据
            self?.collectionView.reloadData()
            //3、结束动画
            self?.loadDataCompletion()
        }
    }
}

