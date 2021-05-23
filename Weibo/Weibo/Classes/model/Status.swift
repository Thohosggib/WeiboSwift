//
//  Status.swift
//  Weibo
//
//  Created by Heaven on 15/7/1.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

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
    var pic_urls: [[String: String]]?
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
    class func loadStatus(finished: (statuses: [Status]) -> ()) {
        assert(sharedUserAccount != nil, "必须登录之后才能访问网络")
        
        let params = ["access_token": sharedUserAccount!.access_token]
        
        // 发起网络请求，异步加载数据
        NetworkTools.sharedNetworkTools().GET(WB_Home_Timeline_URL, parameters: params, success: { (_, JSON) -> Void in
            
            // 从结果中获取微博的数组
            if let array = JSON["statuses"] as? [[String: AnyObject]] {
                // array 就是拿到的微博数组，直接回调返回
                finished(statuses: statuses(array))
            }
            
            }) { (_, error) -> Void in
                print(error)
        }
    }
    
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

