//
//  MainViewController.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab = MainTabBar()
        
        // 利用 KVC 赋值
        setValue(tab, forKey: "tabBar")
        tab.composedButton.addTarget(self, action: "compusedButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        addChildViewControllers()
    }
    
    // compusedButton点击事件
    func compusedButton() {
        print(__FUNCTION__)
        print("发微博")
    }
    
    // 添加全部子控件
    private func addChildViewControllers() {
        // 1. 读取JSON
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        // 2. 反序列化  do  try
        do {
            let array =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            for dict in array as! [[String: String]]{
                addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
            }
        }catch{
            // JSON 信息有错的话，直接根据字符串加载界面
            addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
            addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
            addChildViewController("DiscoverTableViewController", title: "发现", imageName: "tabbar_discover")
            addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
        }
    }
    
    // 添加单个控制器
    private func addChildViewController(viewController: String, title: String, imageName: String) {
        
        // 字符串转成类
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let cls: AnyClass = NSClassFromString(ns + "." + viewController)!
        let vc = cls.new() as! UIViewController
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let navagation = UINavigationController(rootViewController: vc)
        addChildViewController(navagation)
    }
}
