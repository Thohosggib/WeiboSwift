//
//  User.swift
//  Weibo
//
//  Created by Heaven on 15/7/2.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

class User: NSObject {
    
    /// 用户UID
    var id: Int = 0
    /// 友好显示名称
    var name: String?
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    /// 是否是微博认证用户，即加V用户，true：是，false：否
    var verified: Bool = false
    /// 认证类型 -1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = -1
    
    static let properties = ["id", "name", "profile_image_url", "verified", "verified_type"]
    
    ///  字典转模型函数
    init(dict :[String :AnyObject]) {
        super.init()
        for key in User.properties {
            if dict[key] != nil {
                setValue(dict[key], forKey: key)
            }
        }
    }
    
    override var description: String {
        let dict = dictionaryWithValuesForKeys(User.properties)
        
        return "\(dict)"
    }
}
