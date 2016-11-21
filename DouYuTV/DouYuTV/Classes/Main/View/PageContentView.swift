//
//  PageContentView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/17.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

// MARK: - 定义协议
protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView, progress: CGFloat,currentIndex: Int, targetIndex: Int)
}

private let Identifier = "pageContentIdentifier"

class PageContentView: UIView {
    // MARK: - 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentVc : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var currentIndex : Int = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    // MARK: - 懒加载
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //创建流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = true
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self,forCellWithReuseIdentifier:Identifier)
        return collectionView
    }()
    
    // MARK: - 自定义一个构造函数
    init(frame: CGRect ,childVcs : [UIViewController] ,parentVc : UIViewController?) {
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
            parentVc?.addChildViewController(childVc)
        }
        //2、添加collectionView
        addSubview(collectionView)
        collectionView.frame = self.bounds
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

// MARK: - collectionView的代理方法
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
        currentIndex = Int(startOffsetX / scrollView.frame.width)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate == true { return }
        var progress : CGFloat = 0
        var targetIndex : Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        let width = scrollView.frame.width
        if currentOffsetX > startOffsetX { //左滑动
            //计算进度
            progress = (currentOffsetX - width * CGFloat(currentIndex)) / width
            //计算目标下标
            targetIndex = currentIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
        } else if currentOffsetX < startOffsetX {   //右滑动
            //计算进度
            progress = (width * CGFloat(currentIndex) - currentOffsetX) / width
            //计算目标下标
            targetIndex = currentIndex - 1
            if targetIndex <= 0 {
                targetIndex = 0
            }
        } else {
            //计算进度
            progress = 0
            //计算目标下标
            targetIndex = currentIndex
        }
        //把计算所得传递给pageTitleVIew
        delegate?.pageContentView(contentView: self, progress: progress,currentIndex: currentIndex, targetIndex: targetIndex)
    }
}

// MARK: - 对外可用的方法
extension PageContentView {
    func setCurrentIndex(_ currectIndex : Int) {
        isForbidScrollDelegate = true
        let point : CGPoint = CGPoint(x: collectionView.frame.size.width * CGFloat(currectIndex), y: 0)
        collectionView.setContentOffset(point, animated: true)
    }
}

