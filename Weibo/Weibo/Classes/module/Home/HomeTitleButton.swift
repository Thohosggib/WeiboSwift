//
//  HomeTitleButton.swift
//  Weibo
//
//  Created by Heaven on 6/28/15.
//  Copyright © 2015 Heaven. All rights reserved.
//

import UIKit

class HomeTitleButton: UIButton {
    
    class func button(title: String) -> HomeTitleButton {
        
        let btn = HomeTitleButton()
        
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        btn.setTitle(title + " ", forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        btn.sizeToFit()
        
        return btn
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.bounds.width
    }
}
