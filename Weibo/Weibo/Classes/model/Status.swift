//
//  Status.swift
//  Weibo
//
//  Created by Heaven on 15/7/1.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit
import SDWebImage
/// 访问微博首页 URL
private let WB_Home_Timeline_URL = "2/statuses/home_timeline.json"

class Status: NSObject {

    // 数据模型数据
    
    /// 微博创建时间
    var created_at: String?
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 配图数组
    var pic_urls: [[String: String]]? {
        didSet {
            // 设置 imageURLs 数组
            imageURLs = [NSURL]()
            
            // 生成并添加 URL
            for dict in pic_urls! {
               
                let urlString = dict["thumbnail_pic"]!
                imageURLs?.append(NSURL(string: urlString)!)
                
            }
        }
    }
    /// 配图的 URL 数组
    var imageURLs: [NSURL]?
    /// 用户模型
    var user: User?
    
    /// 类属性数组
    static let properties = ["created_at", "id", "text", "source", "pic_urls","user"]
    
    // 字典转模型函数
    init(dict: [String: AnyObject]) {
        super.init()
        for key in Status.properties {
            
            if dict[key] == nil || key == "user" {
                continue
            }
            
            // 如果存在，使用 KVC
            setValue(dict[key], forKey: key)
        }
        
        // 判断字典中是否包含 user
        if let userDict = dict["user"] as? [String: AnyObject] {
            
            // 给 user 属性设置数值
            user = User(dict: userDict)
        }
    }
    
    override var description: String {
        let dict = dictionaryWithValuesForKeys(Status.properties)
        return "\(dict)"
    }
    
    ///  加载数据
    class func loadStatus(finished: (statuses: [Status]?, error: NSError?) -> ()) {
        assert(sharedUserAccount != nil, "必须登录之后才能访问网络")
        
        let params = ["access_token": sharedUserAccount!.access_token]
        
        // 发起网络请求，异步加载数据
        NetworkTools.sharedNetworkTools().GET(WB_Home_Timeline_URL, parameters: params, success: { (_, JSON) -> Void in
            
            // 从结果中获取微博的数组
            if let array = JSON["statuses"] as? [[String: AnyObject]] {
                // 1. 获得微博的模型数组
                let list = statuses(array)
                
                // 2. 异步缓存微博数组中的图像
                cacheWebImages(list, finished: finished)
                
                return
            }
            // 回调空数据，解析失败或者其他原因
            finished(statuses: nil, error: nil)
            
            }) { (_, error) -> Void in
                print(error)
                finished(statuses: nil, error: error )
        }
    }
    
    /// 缓存微博数组中的所有图像
    private class func cacheWebImages(list: [Status], finished: (statuses: [Status]?, error: NSError?) -> ()) {
        // 0.定义群组
        let group = dispatch_group_create()
        
        // 1. 遍历数组
        for s in list {
        
            // 2. 判断imageURLs 是否为空
            if s.imageURLs == nil || s.imageURLs!.isEmpty {
                continue
            }
          
            // 进一步遍历imageURLs的数组，缓存数组中的图片
            for url in s.imageURLs! {
               
                // 1> 进入组
                dispatch_group_enter(group)
                
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) -> Void in
                    // 代码执行至此，说明图片已经被缓存
                    //print(NSHomeDirectory())
                    // 2> 离开组
                    dispatch_group_leave(group)
                })
            }
        }
        // 3> 监听群组调度执行
        dispatch_group_notify(group, dispatch_get_main_queue()) {
            print("缓存结束")
            // 完成回调
            finished(statuses: list, error: nil)
        }
    
    }
    
    ///
    class func statuses(array: [[String: AnyObject]]) -> [Status] {
        // 可变数组
        var arrayM = [Status]()
        // 遍历数组
        for dict in array {
        arrayM.append(Status(dict: dict))
        }
      return arrayM
    }

}

