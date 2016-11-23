//
//  BaseViewController.swift
//  DouYuTV
//
//  Created by 王建伟 on 2016/11/23.
//  Copyright © 2016年 jifusheng. All rights reserved.
//  基础控制器，带加载动画的

import UIKit

class BaseViewController: UIViewController {
    // MARK: 定义属性需子类赋值
    var contentView : UIView?
    
    // MARK: 懒加载属性
    fileprivate lazy var animaImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        return imageView
    }()
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension BaseViewController {
    func setupUI() {
        //1、隐藏contentView
        contentView?.isHidden = true
        //2、添加执行动画的视图
        view.addSubview(animaImageView)
        //3、执行动画
        animaImageView.startAnimating()
    }
    
    func loadDataCompletion() {
        //1、结束动画
        animaImageView.stopAnimating()
        //2、隐藏animaImageView
        animaImageView.isHidden = true
        //3、显示contentView
        contentView?.isHidden = false
    }
}


