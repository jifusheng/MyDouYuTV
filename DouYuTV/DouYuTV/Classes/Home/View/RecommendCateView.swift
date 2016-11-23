//
//  RecommendCateView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  推荐分类视图

import UIKit

private let kOneItemCellCount = 8
private let cateIdentifier = "CateCollectionCell"

class RecommendCateView: UIView {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var pageControl: UIPageControl!
    
    fileprivate var cateArray : [BaseGroupModel] = [BaseGroupModel]()
    
    var games : [BaseGroupModel]? {
        didSet {
            //移除第一个数据
            games?.removeFirst()
            //从数组中取出15个数据
            for (index, gameM) in games!.enumerated() {
                if index < 15 {
                    cateArray.append(gameM)
                }
            }
            if games!.count > 15 {
                //创建一个新的模型添加到数组
                let gameModel = GameModel()
                gameModel.tag_name = "更多分类"
                cateArray.append(gameModel)
            }
            //刷新数据
            collectionView.reloadData()
            //设置pageControl
            pageControl.numberOfPages = (cateArray.count + kOneItemCellCount - 1) / kOneItemCellCount
            //显示pageControl
            pageControl.isHidden = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)
        //隐藏pageControl
        pageControl.isHidden = true
        //设置collectionView的数据源和代理
        collectionView.dataSource = self
        collectionView.delegate = self;
        //注册cell
        collectionView.register(UINib(nibName: "CateCollectionCell", bundle: nil), forCellWithReuseIdentifier: cateIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kScreenW, height: collectionView.bounds.height)
    }
}

// MARK: - 对外提供一个快速创建的方法
extension RecommendCateView {
    class func recommendCateView() -> RecommendCateView {
        return Bundle.main.loadNibNamed("RecommendCateView", owner: nil, options: nil)?.first as! RecommendCateView
    }
}

// MARK: - 实现collectionView的数据源方法
extension RecommendCateView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cateArray.count + kOneItemCellCount - 1) / kOneItemCellCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cateIdentifier, for: indexPath) as! CateCollectionCell
        setupCellDateWith(cell: cell, indexPath: indexPath)
        return cell
    }
    private func setupCellDateWith(cell: CateCollectionCell, indexPath: IndexPath) {
        //计算起始位置
        let startIndex = indexPath.item * kOneItemCellCount
        var endIndex = (indexPath.item + 1) * kOneItemCellCount - 1
        //判断越界问题
        if endIndex >= cateArray.count {
            endIndex = cateArray.count - 1
        }
        //给cell赋值
        cell.itemArray = Array(cateArray[startIndex ... endIndex])
    }
}

// MARK: - 实现collectionView的代理方法
extension RecommendCateView : UICollectionViewDelegate {
    // MARK: - 监听collectiView的滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let currentPage : Int = Int((offsetX + scrollView.frame.width * 0.5) / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}


