//
//  RecommendCycleView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/19.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  图片轮播视图

import UIKit

private let kCycleIdentifier = "CycleCollectionCell"

class RecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    fileprivate var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]? {
        didSet {
            //1、刷新表格
            collectionView.reloadData()
            //2、设置pageControl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //3、默认让collectionView滚动到中间某一个item
            let indexPath = IndexPath(item: pageControl.numberOfPages * 100, section: 0)
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            //4、添加定时器(先移除后添加)
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = .init(rawValue: 0)
        //设置collectionView的数据源和代理
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
        collectionView.register(UINib(nibName: "CycleCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCycleIdentifier)
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
         return (cycleModels?.count ?? 0) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleIdentifier, for: indexPath) as! CycleCollectionCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}

// MARK: - 实现collectionView的代理方法
extension RecommendCycleView : UICollectionViewDelegateFlowLayout {
    // MARK: - 设置item的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  collectionView.bounds.size
    }
    // MARK: - 监听collectionView的滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let currentPage : Int = Int((offsetX + scrollView.frame.width * 0.5) / scrollView.frame.width)
        pageControl.currentPage = currentPage % (cycleModels?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK: - 对定时器的操作方法
extension RecommendCycleView {
    // MARK: - 添加定时器
    func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    // MARK: - 移除定时器
    func removeCycleTimer() {
        //从运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    // MARK: - 滚动到下一张
    @objc private func scrollToNext() {
        //获取当前的偏移量
        var currentOffsetX = collectionView.contentOffset.x
        let allCount = collectionView(collectionView, numberOfItemsInSection: 0)
        let width = collectionView.bounds.width
        if currentOffsetX == CGFloat(allCount - 1) * width {
            currentOffsetX = -width
        }
        //计算要偏移的位置
        let offsetX = currentOffsetX + width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
