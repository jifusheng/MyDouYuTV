//
//  RecommendCateView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  推荐分类视图

import UIKit

private let cateIdentifier = "GameCollectionCell"

class RecommendCateView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    fileprivate var cateArray : [GameModel] = [GameModel]()
    
    var games : [GameModel]? {
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
            pageControl.numberOfPages = 2
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
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: cateIdentifier)
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
        return cateArray.count 
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cateIdentifier, for: indexPath) as! GameCollectionCell
        cell.baseModel = cateArray[indexPath.item]
        return cell
    }
}

// MARK: - 实现collectionView的代理方法
extension RecommendCateView : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    // MARK: - 设置item的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenW / 4, height: 80)
    }
    // MARK: - 监听item的点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    // MARK: - 监听collectiView的滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let currentPage : Int = Int((offsetX + scrollView.frame.width * 0.5) / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}


