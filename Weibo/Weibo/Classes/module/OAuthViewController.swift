//
//  OAuthViewController.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking

class OAuthViewController: UIViewController, UIWebViewDelegate {

    // 0. 定义常量
    private let WB_Client_ID = "3695305817"
    private let WB_Redirect_URI = "http://www.zzu.edu.cn"
    private let WB_App_Secret = "531f78d1eb5417456f3b6fc0f99b7fc2"
    
    // 1. 加载授权界面
    lazy var webView: UIWebView? = {
    
        let WV = UIWebView()
        WV.delegate = self
        return WV
    }()
    
    
    override func loadView() {

        // 根视图设置为webView
        view = webView
        
        // 设置 nav 信息
        title = "新浪微博"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
    }
    
    func close() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }

   override func viewDidLoad() {
         // 加载授权界面
        loadAuthPage()
    }

    /// 加载授权界面
    func loadAuthPage() {
    
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_Client_ID)&redirect_uri=\(WB_Redirect_URI)"
        
        // 添加 ! 一定能生成
        let url = NSURL(string: urlString)!
        
        webView?.loadRequest(NSURLRequest(URL: url))
    }

    // Mark: -UIWebViewDelegate
    // 在 iOS 开发中，如果代理返回 true，表示一切正常，如果返回 false，表示什么也不做
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType:
        UIWebViewNavigationType) -> Bool {

        //print(request)
        // 0. URL的完整字符串
        let urlString = request.URL!.absoluteString
        print(urlString)
        
        // 1. 如果 不是回调的地址 是新浪的 URL ，就继续加载
        if !urlString.hasPrefix(WB_Redirect_URI) {
            return true
        }
        
        // 2. 如果是回调地址，需要根据 URL 中的内容判断是否有授权码
        print("需要判断")
        
        // 获取请求 URL 中的查询字符串
        let query = request.URL!.query!
        let codeStr = "code="
        
        // 判断是否包含 code＝
        if query.hasPrefix(codeStr) {
            
            print("获取授权码")
            // 授权码
            let code = query.substringFromIndex(advance(codeStr.endIndex, 0))
            print("获取授权码\(code)")
            
            loadAccessToken(code)
        }else {
            print("取消授权")
            close()
        }
        
        return false
    }

    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }

    // 使用授权码获取token
    private func loadAccessToken(code: String) {
    
        // 1. urlString
        let urlString = "oauth2/access_token"
        
        // 2. 请求参 数
        let params = ["client_id": WB_Client_ID,
            "client_secret": WB_App_Secret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": WB_Redirect_URI]
        
        // 3. 发起网络请求
        NetworkTools.sharedNetworkTools().POST(urlString, parameters: params, success: { (_, JSON) -> Void in
            // 字典转模型 －> 加载用户信息，链式调用 Alamofire
            UserAccount(dict: JSON as! [String : AnyObject]).loadUserInfo { (account, error) -> () in
                
                // 判断账户信息是否正确
                if account != nil {
                    print(account)
                   
                    // 1. 设置全局的 account
                    sharedUserAccount = account
                    
                    // 2. 发送通知
                    // object = false 表示显示 WelcomeViewController
                    NSNotificationCenter.defaultCenter().postNotificationName(YTSwitchRootVCNotification, object: false)
                    
                    // 3. 关闭当前控制器
                    self.close()
                    
                    return
                }
                
                print(error)
                SVProgressHUD.showInfoWithStatus("您的网络不给力")
            }
            
            }) { (_, error) -> Void in
                print(error)
                SVProgressHUD.showInfoWithStatus("您的网络不给力")
        }
    }
}
