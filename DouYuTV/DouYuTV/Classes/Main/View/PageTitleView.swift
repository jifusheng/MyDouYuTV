//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/17.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

// MARK: - 设置代理
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView ,selectedIndex index : Int)
}

// MARK: - 定义一些颜色常量
private var kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private var kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    // MARK: - 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
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
        scrollLine.backgroundColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
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
            label.textColor = index == 0 ? UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2) : UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            //3、设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4、把Label添加到scrollView
            scrollView.addSubview(label)
            //5、把Label添加到数组中
            titleLabels.append(label)
            //6、给Label添加手势
            label.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.labelTapGesture(_:)))
            label.addGestureRecognizer(gesture)
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
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

// MARK: - 事件处理
extension PageTitleView {
    @objc fileprivate func labelTapGesture(_ tap : UITapGestureRecognizer) {
        //1、获取点击之前的Label
        let lastLabel = titleLabels[currentIndex]
        //2、获取当前点击的Label
        guard let currentLabel = tap.view as? UILabel else { return }
        //3、修改Label的文字颜色
        lastLabel.textColor = .darkGray
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        //4、把当前的下标保存
        currentIndex = currentLabel.tag
        //5、设置滑块的位置,执行动画
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.center.x = currentLabel.center.x
        }
        //6、通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLabel.tag)
    }
}

// MARK: - 外部可以调用的方法
extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat ,currentIndex: Int, targetIndex: Int) {
        //1、取出当前的或目标Label
        let currentLbl = titleLabels[currentIndex]
        let targetLbl = titleLabels[targetIndex]
        //2、处理滑块的逻辑
        let moveTotalX = targetLbl.frame.origin.x - currentLbl.frame.origin.x
        let movingX = moveTotalX * progress
        scrollLine.frame.origin.x = currentLbl.frame.origin.x + movingX
        //3、设置渐变颜色
        //3.1、颜色渐变范围
        let colorChanged = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        //3.2、设置变化的当前的Label
        currentLbl.textColor = UIColor(r: kSelectedColor.0 - colorChanged.0 * progress, g: kSelectedColor.1 - colorChanged.1 * progress, b: kSelectedColor.2 - colorChanged.2 * progress)
        //3.3、设置变化的目标的Label
        targetLbl.textColor = UIColor(r: kNormalColor.0 + colorChanged.0 * progress, g: kNormalColor.1 + colorChanged.1 * progress, b: kNormalColor.2 + colorChanged.2 * progress)
        if currentIndex == targetIndex {
            targetLbl.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        }
        //4、记录当前的下标
        self.currentIndex = targetIndex
    }
}


