//
//  EntertainmentViewController.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  娱乐

import UIKit

private let kCateViewH : CGFloat = 190

class EntertainmentViewController: HomeBaseViewController {

    fileprivate var enterainmentVm = EntertainmentVM()
    
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

extension EntertainmentViewController {
    // Mark - 加载数据
    override func loadData() {
        baseVm = enterainmentVm
        enterainmentVm.loadAllEntertainmentData { [weak self] in
            //1、处理数据（如果room_list没有数据就删除）
            for (index, gameModel) in (self?.enterainmentVm.anchorGroups.enumerated())! {
                if gameModel.anchors.count == 0 {
                    self?.enterainmentVm.anchorGroups.remove(at: index)
                }
            }
            //2、刷新数据
            self?.collectionView.reloadData()
            //3、给cateView传递数据
            self?.cateView.games = self?.enterainmentVm.anchorGroups
        }
    }
}
