//
//  PopoverPresentationController.swift
//  Weibo
//
//  Created by Heaven on 6/28/15.
//  Copyright © 2015 Heaven. All rights reserved.
//

import UIKit

/// iOS 8.0 推出的，专门用于负责视图控制器之间的转场
class PopoverPresentationController: UIPresentationController {
    
    /// 展现视图的 frame
    var presentFrame = CGRectZero
    
    /// 遮罩视图
    lazy var dummyView: UIView = {
        let dummyV = UIView()
        dummyV.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        return dummyV
        }()
    
    /**
    containerView 容器视图，放置展现出来的视图的
    presentedView() 被展现出来的视图的
    
    */
    ///  实例化转场控制器
    ///
    ///  :param: presentedViewController  被`展现`的控制器
    ///  :param: presentingViewController 文档上说，发起的控制器，Xcode 6 nil，Xcode 7 野指针
    ///
    ///  :returns: 展现控制器
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        
        print(presentedViewController)
        // 因为还没有显示，容器视图还没有创建
        print(containerView)
        
        prepareDummyView()
    }
    
    func close() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func prepareDummyView() {
        let tap = UITapGestureRecognizer(target: self, action: "close")
        dummyView.addGestureRecognizer(tap)
    }
    
    ///  容器视图将要重新布局子视图
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // 添加并且设置 dummyView
        dummyView.frame = containerView!.bounds
        containerView?.insertSubview(dummyView, atIndex: 0)
        
        // 设置视图大小
        presentedView()?.frame = presentFrame
    }
}

