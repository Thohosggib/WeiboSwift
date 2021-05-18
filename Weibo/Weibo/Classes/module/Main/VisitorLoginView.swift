//
//  VisitorLoginView.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

protocol VisitorLoginViewDelegate: NSObjectProtocol {
    func visitorRegisterButtonClicked()
    func visitorLoginButtonClicked()
}

class VisitorLoginView: UIView {
    
    weak var delegate: VisitorLoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewInfo(iconName: String, message: String, isHome: Bool) {
        messageLabel.text = message
        
        if isHome {
            homeView.hidden = false
            cycleView.image = UIImage(named: "visitordiscover_feed_image_smallicon")
        } else {
            homeView.hidden = true
            cycleView.image = UIImage(named: iconName)
            // 将视图层次置后
            sendSubviewToBack(maskIconView)
        }
    }
    
    //  启动动画
    func startAnmiation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.duration = 20
        anim.repeatCount = MAXFLOAT
        cycleView.layer.addAnimation(anim, forKey: nil)
    }
    
    private func setupUI() {
        
        // 1. 添加子控件
        addSubview(cycleView)
        addSubview(homeView)
        addSubview(maskIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 2. 自动布局
        // 圆环
        cycleView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: cycleView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: cycleView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -80))
        
        // 房子
        homeView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: cycleView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: cycleView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
        
        // 文字标签
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: cycleView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cycleView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20))
        // VFL
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(240)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": messageLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subView(40)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": messageLabel]))
        
        // 遮盖
        maskIconView.translatesAutoresizingMaskIntoConstraints = false
        // VFL
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView" : maskIconView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]-160-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView" : maskIconView]))
        backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
        
        // 注册按钮
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(100)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": registerButton]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subView(40)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": registerButton]))
        
        // 登录按钮
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(100)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": loginButton]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subView(40)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": loginButton]))
        
    }
    
    // 懒加载控件
    // 圆环
    lazy var cycleView: UIImageView = {
        let image = UIImage(named: "visitordiscover_feed_image_smallicon")
        return UIImageView(image: image)
        }()
    
    // 房子
    lazy var homeView: UIImageView = {
        let image = UIImage(named: "visitordiscover_feed_image_house")
        return UIImageView(image: image)
        }()
    
    // 遮盖
    lazy var maskIconView: UIImageView = {
        let image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        return UIImageView(image: image)
        }()
    
    // 文字标签
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame:CGRectMake(0, 0, 240, 40))
        label.text = "我就无语了！！！Xcode7就是一个坑爹玩意儿啊！！！坑爹玩意儿啊！！啊啊啊啊啊！！！！"
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        label.textAlignment = NSTextAlignment.Center
        label.preferredMaxLayoutWidth = 224
        label.numberOfLines = 2
        label.sizeToFit()
        return label
        }()
    
    // 注册按钮
    lazy var registerButton: UIButton = {
        
        let button = UIButton(frame: CGRectMake(0, 0, 100, 40))
        button.setTitle("注册", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        button.addTarget(self, action: "register", forControlEvents: UIControlEvents.TouchUpInside)
        return button
        }()
    
    // 登录按钮
    lazy var loginButton: UIButton = {
        
        let button = UIButton(frame: CGRectMake(200, 220, 100, 40))
        
        button.setTitle("登录", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        button.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        return button
        }()
    
    func register() {
        delegate?.visitorRegisterButtonClicked()
    }
    
    func login() {
        delegate?.visitorLoginButtonClicked()
    }
}


