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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            //1、刷新数据
            self?.collectionView.reloadData()
            //2、给cateView传递数据
            self?.cateView.games = self?.gameVm.anchorGroups
        }
    }
}

