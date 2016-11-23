//
//  FunViewController.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  趣玩

import UIKit

private let kCateViewH : CGFloat = 190

class FunViewController: HomeBaseViewController {

    fileprivate var funVm = FunVM()
    
    fileprivate lazy var cateView : RecommendCateView = {
        let cateView = RecommendCateView.recommendCateView()
        cateView.frame = CGRect(x: 0, y: -kCateViewH, width: kScreenW, height: kCateViewH)
        return cateView
    }()
}

extension FunViewController {
    override func setupUI() {
        super.setupUI()
        //1、把cateView添加到collectionView中
        collectionView.addSubview(cateView)
        //2、设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCateViewH, left: 0, bottom: 0, right: 0)
    }
}

// Mark - 加载数据
extension FunViewController {
    // Mark - 加载趣玩数据
    override func loadData() {
        baseVm = funVm
        funVm.loadAllFunData { [weak self] in
            //1、刷新数据
            self?.collectionView.reloadData()
            //2、给cateView传递数据
            self?.cateView.games = self?.funVm.anchorGroups
            guard let anchorGroups = self?.funVm.anchorGroups else { return }
            if anchorGroups.count <= 8 {
                self?.cateView.frame = CGRect(x: 0, y: -kCateViewH + 15, width: kScreenW, height: kCateViewH - 15)
                //2、设置collectionView的内边距
                self?.collectionView.contentInset = UIEdgeInsets(top: kCateViewH - 15, left: 0, bottom: 0, right: 0)
            }
            //3、结束动画
            self?.loadDataCompletion()
        }
    }
}
