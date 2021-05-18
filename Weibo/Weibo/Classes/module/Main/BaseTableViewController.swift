//
//  BaseTableViewController.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController,VisitorLoginViewDelegate {
    
    /// 用户登录标记
    var userLogon = sharedUserAccount != nil

    /// 访客视图
    var visitorView: VisitorLoginView?
    
    override func loadView() {
        print("用户登录 \(userLogon)")
        
        // 根据是否登录，显示不同的界面
        userLogon ? super.loadView() : setupVisitorView()
        
    }
    
    // 创建访客视图
    func setupVisitorView() {
        
        // 设置代理
        visitorView = VisitorLoginView()
        visitorView?.delegate = self
        view = visitorView!
        
        // 添加导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorRegisterButtonClicked")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorLoginButtonClicked")
    }
    
    func visitorRegisterButtonClicked() {
        print("注册")
    }
    
    func visitorLoginButtonClicked() {
        let vc = OAuthViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        // 对于独立的视图控制器，可以使用 modal 展示
        presentViewController(nav, animated: true, completion: nil)
    }
    
    
    
}

