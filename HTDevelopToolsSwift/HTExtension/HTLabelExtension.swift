//
//  HTLabelExtension.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/2/25.
//  Copyright © 2018年 HT. All rights reserved.
//

import Foundation
import UIKit

/// properties
extension UILabel {
    
    
    
}
/// Method
extension UILabel {
    
    
    /// 创建一个label
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - width: width
    ///   - height: height 
    convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    /// 用frame创建一个label
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - width: 宽
    ///   - height: 高
    /// - Returns: label
    class func ht_init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        return label
    }
    
    /// 创建一个label
    ///
    /// - Returns: label
    class func ht_init() -> UILabel {
        
        let label = UILabel()
        return label
    }
    
    /// 设置label的内容(默认"") 字体(默认为系统13号常规字体) 字体颜色(默认为灰色)
    ///
    /// - Parameters:
    ///   - text: 内容
    ///   - font: 字体
    ///   - textColor: 字体颜色
    public func ht_set(text: String = "", font: UIFont = UIFont.systemFont(ofSize: 13), textColor: UIColor = .gray) {
        self.text = text
        self.textColor = textColor
        self.font = font
    }
    
    /// 是否自适应大小 (默认为true)
    ///
    /// - Parameter isFit: 布尔值
    public func ht_set(isFit: Bool = true) {
        if isFit {
            self.sizeToFit()
        }
    }
    
    /// 添加边框、颜色及切圆角 (默认为灰色1.5宽的边框,圆角半径为5)
    ///
    /// - Parameters:
    ///   - borderWith: 边框宽
    ///   - borderColor: 边框颜色
    ///   - cornerRadius: 圆角半径
    public func ht_add(borderWith: CGFloat = 1.5, borderColor: UIColor = .gray, cornerRadius: CGFloat = 5) {
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        if cornerRadius > 0 {
            self.clipsToBounds = true
        }
    }
    
    /// 设置行数及对齐方式
    ///
    /// - Parameters:
    ///   - lines: 行数
    ///   - textAlignment: 对齐方式
    public func ht_set(lines: Int, textAlignment: NSTextAlignment) {
        self.numberOfLines = lines
        self.textAlignment = textAlignment
    }
    
    /// 设置富文本
    ///
    /// - Parameters:
    ///   - attributedText: 富文本内容
    ///   - attributedName: 富文本的key值
    ///   - attributedValue: 富文本的value值
    ///   - location: 开始位置
    ///   - length: 长度
    public func ht_set(attributedText: String, attributedName: NSAttributedStringKey, attributedValue: Any, location: Int, length: Int) {
        let attriStr = NSMutableAttributedString(string: attributedText)
        attriStr.addAttributes([attributedName: attributedValue], range: NSRange(location: location, length: length))
        self.attributedText = attriStr
    }
}













