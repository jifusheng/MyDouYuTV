//
//  PageContentView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/17.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

private let Identifier = "pageContentIdentifier"

class PageContentView: UIView {
    // MARK: - 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVc : UIViewController
    
    // MARK: - 懒加载
    fileprivate lazy var collectionView : UICollectionView = {
        //创建流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建collectionView
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self,forCellWithReuseIdentifier:Identifier)
        return collectionView
    }()
    
    // MARK: - 自定义一个构造函数
    init(frame: CGRect ,childVcs : [UIViewController] ,parentVc : UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        // MARK: - 创建UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 添加子控件
extension PageContentView {
    //创建UI
    fileprivate func setupUI() {
        //1、把所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
        //2、添加collectionView
        addSubview(collectionView)
    }
}

// MARK: - collectionView的数据源方法
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出缓存池中的cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath)
        //由于重复利用，可能重复添加
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        //把控制器的view添加到cell上
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}



