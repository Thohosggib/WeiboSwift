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
    
    // MARK: - 数据模型属性
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
    
    /// 类属性数组
    static let properties = ["created_at", "id", "text", "source", "pic_urls"]
    
    ///  字典转模型函数
    init(dict: [String: AnyObject]) {
        super.init()
        
        for key in Status.properties {
            // 判断属性字典中的key对应的值是否存在
            if dict[key] != nil {
                // 如果存在，使用 kvc 设置数值，使用之前，需要调用 super.init 初始化对象属性
                setValue(dict[key], forKey: key)
            }
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
    
    /// 使用传入的数组，完成网络模型转 Status 数组
    private class func statuses(array: [[String: AnyObject]]) -> [Status] {
        
        // 定义可变数组
        var arrayM = [Status]()
        
        // 遍历 array
        for dict in array {
            arrayM.append(Status(dict: dict))
        }
        
        return arrayM
    }
}

