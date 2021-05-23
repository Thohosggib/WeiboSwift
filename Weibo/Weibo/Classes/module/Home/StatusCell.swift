//
//  StatusCell.swift
//  Weibo
//
//  Created by Heaven on 15/7/1.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit
import FFAutoLayout

class StatusCell: UITableViewCell {
    
    ///  微博数据模型
    var status: Status? {
        didSet {
            nameLabel.text = status?.user?.name
            timeLabel.text = "刚刚"
            sourceLabel.text = "来自 微博"
        }
    }
    
    // 函数执行的时候，frame 是 (0.0, 0.0, 320.0, 44.0)，对于 iPhone 6 & 6+ 尺寸是不对的
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        // 头像
        iconView.ff_AlignInner(ff_AlignType.TopLeft, referView: self, size: CGSize(width: 34, height: 34), offset: CGPoint(x: 12, y: 12))
        nameLabel.ff_AlignHorizontal(ff_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
        memberIconView.ff_AlignHorizontal(ff_AlignType.CenterRight, referView: nameLabel, size: nil, offset: CGPoint(x: 12, y: 0))
        vipIconView.ff_AlignInner(ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 8, y: 8))
        timeLabel.ff_AlignHorizontal(ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
        sourceLabel.ff_AlignHorizontal(ff_AlignType.CenterRight, referView: timeLabel, size: nil, offset: CGPoint(x: 12, y: 0))
        
        // 测试使用
        iconView.image = UIImage(named: "avatar")
    }
    
    ///  如果使用 sb & xib 开发，使用 fatalError 会直接崩掉
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 控件的懒加载
    lazy var iconView = UIImageView()
    lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.darkGrayColor()
        
        return label
        }()
    lazy var memberIconView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
    lazy var vipIconView: UIImageView = UIImageView(image: UIImage(named: "avatar_grassroot"))
    lazy var timeLabel:UILabel  = {
        
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(10)
        label.textColor = UIColor.orangeColor()
        
        return label
        }()
    lazy var sourceLabel:UILabel  = {
        
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(10)
        label.textColor = UIColor.darkGrayColor()
        
        return label
        }()
    
}
