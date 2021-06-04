//
//  UILabel+Extension.swift
//  Weibo
//
//  Created by Heaven on 7/2/15.
//  Copyright © 2015 Heaven. All rights reserved.
//

import UIKit

extension UILabel {

    convenience init(color: UIColor, fontSize: CGFloat, mutiLines: Bool = false) {
        self.init()
        
        font = UIFont.systemFontOfSize(fontSize)
        textColor = color
        
        if mutiLines {
            numberOfLines = 0
        }
    }
}
