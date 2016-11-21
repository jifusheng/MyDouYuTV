//
//  RecommendGameView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/21.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

private let gameIdentifier = "GameCollectionCell"

class RecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = .init(rawValue: 0)
        //设置collectionView的数据源和代理
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: gameIdentifier)
    }

}

// MARK: - 对外提供一个快速创建的方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK: - collectionView的数据源方法
extension RecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameIdentifier, for: indexPath)
        cell.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(UInt32(255.0))), g: CGFloat(arc4random_uniform(UInt32(255.0))), b: CGFloat(arc4random_uniform(UInt32(255.0))))
        return cell
    }
}

// MARK: - collectionView的代理方法
extension RecommendGameView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

