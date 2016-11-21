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
    
    var groups : [AnchorGroupModel]? {
        didSet {
            //移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            //创建更多组数据
            let moreGroup = AnchorGroupModel()
            moreGroup.tag_name = "更多"
            moreGroup.icon_name = "home_more_btn"
            groups?.append(moreGroup)
            collectionView.reloadData()
        }
    }
    
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
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameIdentifier, for: indexPath) as! GameCollectionCell
        cell.groupModel = groups![indexPath.item]
        return cell
    }
}

// MARK: - collectionView的代理方法
extension RecommendGameView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

