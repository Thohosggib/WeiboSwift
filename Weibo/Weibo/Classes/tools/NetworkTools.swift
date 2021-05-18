//
//  NetworkTools.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    private static let instance: NetworkTools = {
        let urlString = "https://api.weibo.com/"
        let baseURL = NSURL(string: urlString)!
        let tools = NetworkTools(baseURL: baseURL)
        
        // 设置相应的默认反序列化格式
        tools.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as! Set<String>
        
        return tools
    }()
    
    class func sharedNetworkTools() -> NetworkTools {
        return instance
    }
}
