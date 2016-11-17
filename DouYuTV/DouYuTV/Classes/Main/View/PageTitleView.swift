//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/17.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    // MARK: - 定义属性
    fileprivate var titles : [String]
    
    // MARK: - 懒加载一个数组存放所以的Label
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    // MARK: - scrollView懒加载
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    // MARK: - scrollLine懒加载
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        //创建UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView {
    fileprivate func setupUI() {
        //1、添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //2、添加title对应的Label
        setupTitleLabels()
        //3、设置底线和滚动滑块
        setupBottomLineAndScrollLine()
    }
    // MARK: - 创建标题的Label
    private func setupTitleLabels() {
        //0、初始化一些值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        for (index ,title) in titles.enumerated() {
            //1、创建Label
            let label = UILabel()
            //2、设置label属性
            label.text = title
            label.tag = index
            label.font = .systemFont(ofSize: 16)
            label.textColor = .darkGray
            label.textAlignment = .center
            //3、设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4、把Label添加到scrollView
            scrollView.addSubview(label)
            //5、把Label添加到数组中
            titleLabels.append(label)
        }
    }
    // MARK: - 创建底部分割线和小滑快
    private func setupBottomLineAndScrollLine() {
        //1、创建分割线
        let bottomLine = UILabel()
        let bottomLineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - bottomLineH, width: frame.width, height: bottomLineH)
        bottomLine.backgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1.0)
        addSubview(bottomLine)
        //2、创建滑块
        //2.1、取出第一个Label
        guard let firstLabel = titleLabels.first else { return }
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: firstLabel.frame.maxY, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


