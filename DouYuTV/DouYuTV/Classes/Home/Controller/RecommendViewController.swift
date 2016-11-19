//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kItemMargin : CGFloat = 10
private let kItemWidth : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemHeight : CGFloat = kItemWidth * 3 / 4
private let kPrettyItemHeight : CGFloat = kItemWidth * 4 / 3
private let kSetionHeaderH : CGFloat = 50
private let kCellNormalIdentifier = "NormalCollectionCell"
private let kCellPrettyIdentifier = "PrettyCollectionCell"
private let kSetionHeaderIdentifier = "kSetionHeaderIdentifier"

class RecommendViewController: UIViewController {
    
    // MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        //创建流水布局
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //设置item的尺寸
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //设置item的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //设置头的尺寸
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kSetionHeaderH)
        //创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        //设置collectionView的宽高自动适应
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //设置数据源及代理
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
        collectionView.register(UINib(nibName: "NormalCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCellNormalIdentifier)
        collectionView.register(UINib(nibName: "PrettyCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCellPrettyIdentifier)
        //注册header
        collectionView.register(UINib(nibName: "RecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSetionHeaderIdentifier)
        return collectionView
    }()
    fileprivate lazy var recomendVm : RecommendVM = RecommendVM()
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //1、设置UI界面
        setupUI()
        //2、请求数据
        recomendVm.loadData {[weak self] in
            
            //3、刷新数据
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - 设置UI界面
extension RecommendViewController {
    fileprivate func setupUI() {
        //1、添加collectionView
        view.addSubview(collectionView)
    }
}

// MARK: - 实现collectionView的数据源方法
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recomendVm.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let anchorGroup = recomendVm.anchorGroups[section]
        return anchorGroup.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1、取出主播组
        let anchorGroup = recomendVm.anchorGroups[indexPath.section]
        //2、定义cell
        let cell : BaseCollectionCell!
        //3、取出缓存池中的cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellPrettyIdentifier, for: indexPath) as! PrettyCollectionCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellNormalIdentifier, for: indexPath) as! NormalCollectionCell
        }
        //4、给cell赋值
        cell.anchor = anchorGroup.anchors[indexPath.item]
        return cell
    }
}

// MARK: - 实现collectionView的代理方法
extension RecommendViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出缓存池中的header 
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSetionHeaderIdentifier, for: indexPath) as! RecommendHeaderView
        //取出数据
        header.anchorGroup = recomendVm.anchorGroups[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        if indexPath.section == 1 {
            size = CGSize(width: kItemWidth, height: kPrettyItemHeight)
        } else {
            size = CGSize(width: kItemWidth, height: kNormalItemHeight)
        }
        return size
    }
}


