//
//  HomeBaseViewController.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

// MARK: - 定义常量
let kCellNormalIdentifier = "NormalCollectionCell"
let kCellPrettyIdentifier = "PrettyCollectionCell"
private let kSetionHeaderIdentifier = "kSetionHeaderIdentifier"

class HomeBaseViewController: BaseViewController {
    
    // MARK: - 定义属性需子类使用
    var baseVm : BaseViewModel!
    
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
        collectionView.register(UINib(nibName: "PrettyCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCellPrettyIdentifier)
        //注册header
        collectionView.register(UINib(nibName: "RecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSetionHeaderIdentifier)
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1、加载数据
        loadData()
        //2、设置UI界面
        setupUI()
    }
}

// MARK: - 设置UI界面
extension HomeBaseViewController {
    override func setupUI() {
        //1、给父类的contentView赋值
        contentView = collectionView
        
        //2、把collectionView添加到view中
        view.addSubview(collectionView)
        
        //3、调用父类的方法
        super.setupUI()
    }
}

// MARK: - 设置UI界面
extension HomeBaseViewController {
    func loadData() {
        //父类不作实现，需子类实现
    }
}

// MARK: - 实现collectionView的数据源方法
extension HomeBaseViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVm.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVm.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellNormalIdentifier, for: indexPath) as! NormalCollectionCell
        cell.anchor = baseVm.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
}

// MARK: - 实现collectionView的数据源方法
extension HomeBaseViewController : UICollectionViewDelegate {
    @objc(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSetionHeaderIdentifier, for: indexPath) as! RecommendHeaderView
        //取出数据
        let gameGroup = baseVm.anchorGroups[indexPath.section]
        if indexPath.section == 0 {
            gameGroup.icon_name = "home_header_hot"
        }
        header.baseGroup = gameGroup
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1、取出主播房间模型
        let anchor = baseVm.anchorGroups[indexPath.section].anchors[indexPath.item]
        //2、判断主播信息确定要进入那种room
        anchor.isVertical == 0 ? pushNormalViewController() : presentShowViewController()
    }
    // MARK: 普通直播房间
    private func pushNormalViewController() {
        let vc = RoomNormalViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - 秀场直播房间
    private func presentShowViewController() {
        let vc = RoomShowViewController()
        present(vc, animated: true, completion: nil)
    }
}
