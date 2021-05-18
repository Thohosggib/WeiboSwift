//
//  AppDelegate.swift
//  Weibo
//
//  Created by Heaven on 15/6/26.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit
import AFNetworking

/// 全局变量记录用户账号信息，只加载一次用户账号，后续再获取 token，就不再需要去磁盘加载
/// 执行时机，在需要的时候，才会执行，并不是程序一启动就会执行！
var sharedUserAccount = UserAccount.loadAccount()
/// 切换根控制器的通知
let YTSwitchRootVCNotification = "YTSwitchRootVCNotification"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = defaultViewController()
        window?.makeKeyAndVisible()
        
        // 打印归档保存的用户信息
        print(sharedUserAccount)
        
        // 设置全局外观
        setAppearence()
        
        // 设置网络
        setupNetWork()
        
        // 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchViewController:", name:YTSwitchRootVCNotification, object: nil)
     return true
    }
    
    // 注销通知
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: YTSwitchRootVCNotification, object: nil)
    }
    
    ///  切换控制器
    func switchViewController(notification: NSNotification) {
        // 判断 object 是否为 true，如果是，显示 MainViewController
        let isMainVC = notification.object as! Bool
        
        window?.rootViewController = isMainVC ? MainViewController() : WelcomeViewController()
    }
    
    ///  判断加载的默认控制器
    private func defaultViewController() -> UIViewController {
        
        // 1. 判断用户是否登录
        if sharedUserAccount != nil {
            
            // 2. 如果登录，判断是否有新版本
            return isNewUpdate() ? NewFeatureViewController() : WelcomeViewController()
        }
        
        return MainViewController()
    }
    
    /// 是否新版本
    private func isNewUpdate() -> Bool {
        
        // 1. 获取应用程序`当前版本`
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let version = NSNumberFormatter().numberFromString(currentVersion)!.doubleValue
        print(version)
        
        // 2. 从用户偏好中读取应用程序`之前的版本`
        let versionKey = "versionKey"
        let sandBoxVersion = NSUserDefaults.standardUserDefaults().doubleForKey(versionKey)
        print(sandBoxVersion)
        
        // 3. 把当前版本写入用户偏好
        NSUserDefaults.standardUserDefaults().setDouble(version, forKey: versionKey)
        // 从 Xcode 6.0 开始就不需要同步了
        // NSUserDefaults.standardUserDefaults().synchronize()
        
        return version > sandBoxVersion
    }

    /// 设置网络
    private func setupNetWork() {
    
    // 设置网络指示器
    AFNetworkActivityIndicatorManager.sharedManager().enabled = true
    
    // 设置网络缓存
    let urlCache = NSURLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024, diskPath: nil)
    NSURLCache.setSharedURLCache(urlCache)
    
    }
    
    /// 设置全局外观
    private func setAppearence() {
        
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
    }
    
}