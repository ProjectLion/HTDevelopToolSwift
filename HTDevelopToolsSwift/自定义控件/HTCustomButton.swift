//
//  HTCustomButton.swift
//  MagicSwift
//
//  Created by Ht on 2018/8/17.
//  Copyright © 2018年 EscherVR. All rights reserved.
//

import UIKit

/// 自定义按钮
class HTCustomButton: UIControl {
    
    /// 图片位置类型枚举
    public enum ImagePosition {
        case top
        case bottom
        case left
        case right
    }
    
    /// 若朋友你用的frame进行布局可直接使用该构造方法进行实例化
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - imagePostion: 图片位置
    ///   - spacing: 间隔 默认为 5
    convenience init(frame: CGRect, imagePostion: ImagePosition, spacing: CGFloat = 5) {
        self.init(frame: frame)
        space = spacing
        position = imagePostion
        setUpViews(title: title, image: image)
    }
    
    /// 若朋友你用约束布局推荐使用该构造方法进行实例化
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - title: title
    ///   - imagePostion: 图片位置
    ///   - spacing: 间隔 默认为 5
    convenience init(image: UIImage, title: String, imagePostion: ImagePosition, spacing: CGFloat = 5) {
        self.init(frame: .zero)
        space = spacing
        position = imagePostion
        setUpViews(title: title, image: image)
    }
    
    
    /// 间距
    private var space: CGFloat = 0
    /// 图片位置
    private var position: ImagePosition = .left
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var btnImageView = UIImageView()
    
    private var titleLabel = UILabel()
    
    /// 标题字体 默认系统12号字体
    var titleFont = UIFont.systemFont(ofSize: ht_W(12)) {
        willSet {
            titleLabel.font = newValue
        }
    }
    /// 标题颜色 默认 白色
    var titleColor = UIColor.red {
        willSet {
            titleLabel.textColor = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setUpViews(title: String, image: UIImage) {
        btnImageView.image = image
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.font = titleFont
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        addSubview(btnImageView)
        addSubview(titleLabel)
        switch position {
        case .top:
            btnImageView.snp.makeConstraints { (make) in
                make.top.centerX.equalToSuperview()
                make.height.width.equalTo(self.snp.width)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(btnImageView.snp.bottom).offset(space)
                make.bottom.lessThanOrEqualToSuperview()
                make.centerX.width.equalToSuperview()
            }
        case .bottom:
            btnImageView.snp.makeConstraints { (make) in
                make.bottom.centerY.equalToSuperview()
                make.height.width.equalTo(self.snp.width)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(btnImageView.snp.top).offset(-space)
                make.top.lessThanOrEqualToSuperview()
                make.centerX.width.equalToSuperview()
            }
        case .left:
            btnImageView.snp.makeConstraints { (make) in
                make.left.centerY.equalToSuperview()
                make.width.height.equalTo(self.snp.height)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(btnImageView.snp.right).offset(space)
                make.right.lessThanOrEqualToSuperview()
                make.centerY.equalToSuperview()
            }
        case .right:
            btnImageView.snp.makeConstraints { (make) in
                make.right.centerY.equalToSuperview()
                make.width.height.equalTo(self.snp.height)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.right.equalTo(btnImageView.snp.left).offset(-space)
                make.left.lessThanOrEqualToSuperview()
                make.centerY.equalToSuperview()
            }
        }
    }
    
}
