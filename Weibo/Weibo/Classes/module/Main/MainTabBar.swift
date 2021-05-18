//
//  MainTabBar.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

class MainTabBar: UITabBar {
    
    
    // 按钮数量
    private let buttonCount = 5
    
    // 布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        // 计算frame
        let w = bounds.width / CGFloat(buttonCount)
        let h = bounds.height
        let rect = CGRectMake(0, 0, w, h)
        
        // 遍历子视图，调整位置
        var index = 0
        for v in subviews {
            if v is UIControl && !(v is UIButton) {
                
                v.frame = CGRectOffset(rect,CGFloat(index) * w, 0)
                index += index == 1 ? 2 : 1
            }
        }
        
        // 设置 ‘撰写按钮’的位置
        composedButton.frame = CGRectOffset(rect, 2 * w, 0)
        
    }
    
    // 懒加载‘撰写按钮’
    lazy var composedButton: UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState:UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        self.addSubview(button)
        return button
        }()
}
