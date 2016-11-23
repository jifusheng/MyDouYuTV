//
//  CateCollectionCell.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/23.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  分类item

import UIKit

private let cellIdentifier = "GameCollectionCell"

class CateCollectionCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    var itemArray : [BaseGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)
        //设置collectionView的数据源和代理
        collectionView.dataSource = self
        collectionView.delegate = self;
        //注册cell
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionView.bounds.width / 4, height: collectionView.bounds.height / 2)
    }
}

// MARK: - 实现collectionView的数据源方法
extension CateCollectionCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GameCollectionCell
        cell.placeholderImageName = "home_column_more"
        cell.baseModel = itemArray![indexPath.item]
        return cell
    }
}

// MARK: - 实现collectionView的代理方法
extension CateCollectionCell : UICollectionViewDelegate {
    // MARK: - 监听item的点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
