//
//  RecommendCycleView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/19.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  图片轮播视图

import UIKit

private let kCycleIdentifier = "kCycleIdentifier"

class RecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = .init(rawValue: 0)
        //设置collectionView的数据源和代理
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleIdentifier)
    }
}

// MARK: - 提供一个快速创建的方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)!.first as! RecommendCycleView
    }
}

// MARK: - 实现collectionView的数据源方法
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleIdentifier, for: indexPath)
        cell.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        return cell
    }
}

// MARK: - 实现collectionView的代理方法
extension RecommendCycleView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame)
        return  collectionView.bounds.size
    }
}
