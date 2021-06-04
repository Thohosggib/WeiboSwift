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
            contentLabel.text = status?.text
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加控件
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(contentLabel)
        
        /// 头像
        iconView.ff_AlignInner(ff_AlignType.TopLeft, referView: self, size: CGSize(width: 34, height: 34), offset: CGPoint(x: 12, y: 12))
        /// 用户名
        nameLabel.ff_AlignHorizontal(ff_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
        /// 会员
        memberIconView.ff_AlignHorizontal(ff_AlignType.CenterRight, referView: nameLabel, size: nil, offset: CGPoint(x: 12, y: 0))
        /// VIP
        vipIconView.ff_AlignInner(ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 8, y: 8))
        /// 时间
        timeLabel.ff_AlignHorizontal(ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
        /// 来源
        sourceLabel.ff_AlignHorizontal(ff_AlignType.CenterRight, referView: timeLabel, size: nil, offset: CGPoint(x: 12, y: 0))
        /// 内容
        contentLabel.ff_AlignVertical(ff_AlignType.BottomLeft, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 12))
        contentLabel.ff_AlignInner(ff_AlignType.BottomRight, referView: self, size: nil, offset: CGPoint(x: -8, y: -8))
        
        
        // 测试使用
        iconView.image = UIImage(named: "avatar")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 控件的懒加载
    lazy var iconView = UIImageView()
    lazy var nameLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 14)
    lazy var memberIconView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
    lazy var vipIconView: UIImageView = UIImageView(image: UIImage(named: "avatar_grassroot"))
    lazy var timeLabel = UILabel(color: UIColor.orangeColor(), fontSize: 10)
    lazy var sourceLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 10)
    lazy var contentLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 15, mutiLines: true)}
