//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/18.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kPrettyItemHeight : CGFloat = kItemWidth * 4 / 3
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90


class RecommendViewController: HomeBaseViewController {
    
    // MARK: - 懒加载属性
    fileprivate lazy var recommendCycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var recommendGameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    fileprivate lazy var recomendVm : RecommendVM = RecommendVM()
}

// MARK: - 加载数据
extension RecommendViewController {
    override func loadData() {
        //1、请求cell中显示数据
        baseVm = recomendVm
        recomendVm.loadRecommendData {[weak self] in
            //1、数据处理
            guard let groups = self?.recomendVm.anchorGroups else { return }
            for (index ,group) in groups.enumerated() {
                if group.anchors.count == 0 {
                    self?.baseVm.anchorGroups.remove(at: index)
                }
            }
            //2、刷新数据
            self?.collectionView.reloadData()
            //3、把数据传递个gameView
            self?.recommendGameView.groups = self?.recomendVm.anchorGroups
            //4、结束动画
            self?.loadDataCompletion()
        }
        //2、请求图片轮播数据
        recomendVm.loadCycleData { [weak self] in
            self?.recommendCycleView.cycleModels = self?.recomendVm.cycleModels
        }
    }
}

// MARK: - 设置UI界面
extension RecommendViewController {
    override func setupUI() {
        super.setupUI()
        //1、把图片轮播视图添加到collectionView
        collectionView.addSubview(recommendCycleView)
        //2、把游戏视图添加到collectionView
        collectionView.addSubview(recommendGameView)
        //3、设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 实现collectionView的代理方法
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            //3、取出缓存池中的cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellPrettyIdentifier, for: indexPath) as! PrettyCollectionCell
            //4、给cell赋值
            cell.anchor = recomendVm.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
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
    
    // MARK: - 监听collectionView的滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        recommendCycleView.removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        recommendCycleView.addCycleTimer()
    }
}


