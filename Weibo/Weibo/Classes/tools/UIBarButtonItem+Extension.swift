//
//  UIBarButtonItem+Extension.swift
//  Weibo
//
//  Created by Heaven on 15/6/30.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(imageName: String, highlightedImageName: String?) {
    
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        
        let hImageName = highlightedImageName ?? imageName + "_highlighted"
        btn.setImage(UIImage(named: hImageName), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        print(btn.frame)
        self.init(customView: btn)
    
    }
}
