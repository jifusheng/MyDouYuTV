//
//  HomeBaseViewController.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kCellNormalIdentifier = "NormalCollectionCell"
private let kSetionHeaderIdentifier = "kSetionHeaderIdentifier"
private let kCateViewH : CGFloat = 190

class HomeBaseViewController: UIViewController {
    // MARK: - 懒加载属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kSetionHeaderH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        //设置collectionView的宽高自动适应
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //设置数据源及代理
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
        collectionView.register(UINib(nibName: "NormalCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCellNormalIdentifier)
        //注册header
        collectionView.register(UINib(nibName: "RecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSetionHeaderIdentifier)
        return collectionView
        }()
    lazy var cateView : RecommendCateView = {
        let cateView = RecommendCateView.recommendCateView()
        cateView.frame = CGRect(x: 0, y: -kCateViewH, width: kScreenW, height: kCateViewH)
        return cateView
    }()
    
    lazy var gameVm : GameVM = GameVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1、设置UI界面
        setupUI()
    }
}

// MARK: - 设置UI界面
extension HomeBaseViewController {
    fileprivate func setupUI() {
        //把collectionView添加到view中
        view.addSubview(collectionView)
        //把cateView添加到collectionView中
        collectionView.addSubview(cateView)
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCateViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 实现collectionView的数据源方法
extension HomeBaseViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if gameVm.games.count > 15 {
            return 15
        }
        return gameVm.games.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let groups = gameVm.games[section]
        return groups.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let groups = gameVm.games[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellNormalIdentifier, for: indexPath) as! NormalCollectionCell
        cell.anchor = groups.anchors[indexPath.item]
        return cell
    }
}

// MARK: - 实现collectionView的数据源方法
extension HomeBaseViewController : UICollectionViewDelegate {
    @objc(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSetionHeaderIdentifier, for: indexPath) as! RecommendHeaderView
        //取出数据
        let gameGroup = gameVm.games[indexPath.section]
        if indexPath.section == 0 {
            gameGroup.icon_name = "home_header_hot"
        }
        header.baseGroup = gameGroup
        return header
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
