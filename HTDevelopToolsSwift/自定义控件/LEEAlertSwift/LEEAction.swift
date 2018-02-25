//
//  LEEAction.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2018/1/22.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEEAction: NSObject {
    /// action类型
    public var type: LEEActionType?
    
    /// action标题
    public var title: String?
    
    /// action高亮标题
    public var highlight: String?
    
    /// action标题(attributed)
    public var attributedTitle: NSAttributedString?
    
    /// action高亮标题(attributed)
    public var attributedHighlight: NSAttributedString?
    
    /// action字体
    public var font: UIFont?
    
    /// action标题颜色
    public var titleColor: UIColor?
    
    /// action背景颜色
    public var backgroundColor: UIColor?
    
    /// action高亮背景颜色
    public var backgroundHighlightColor: UIColor?
    
    /// action图片
    public var image: UIImage?
    
    /// aciton高亮图片
    public var highlightImage: UIImage?
    
    /// action间距
    public var insets: UIEdgeInsets?
    
    /// action图片间距
    public var imageInsets: UIEdgeInsets?
    
    /// action标题间距
    public var titleInsets: UIEdgeInsets?
    
    /// action圆角率
    public var cornerRadius: CGFloat?
    
    /// action高度
    public var height: CGFloat?
    
    /// action边框宽度
    public var borderWidth: CGFloat?
    
    /// action边框颜色
    public var borderColor: UIColor?
    
    /// action边框位置
    public var borderPosition: LEEActionBorderPosition?
    
    /// action点击不关闭 (仅适用于默认类型)
    public var isClickNotClose: Bool?
    
    /// action点击事件回调
    public var clickBlock: ()->Swift.Void = {}
    
    /// 刷新
    public func update(){
        self.updateBlock(self)
    }
    
    private let updateBlock: (_ action: LEEAction)->() = {
        action in
        
    }
    
    override init() {
        super.init()
    }
    
}



