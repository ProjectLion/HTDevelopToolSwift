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
    @discardableResult open func ht_set(text: String = "", font: UIFont = UIFont.systemFont(ofSize: 13), textColor: UIColor = .gray) -> UILabel {
        self.text = text
        self.textColor = textColor
        self.font = font
        return self
    }
    
    /// 是否自适应大小 (默认为true)
    ///
    /// - Parameter isFit: 布尔值
    @discardableResult open func ht_set(isFit: Bool = true) -> UILabel {
        isFit ? self.sizeToFit() : nil
        return self
    }
    
    /// 设置行数及对齐方式
    ///
    /// - Parameters:
    ///   - lines: 行数
    ///   - textAlignment: 对齐方式
    @discardableResult open func ht_set(lines: Int, textAlignment: NSTextAlignment) -> UILabel {
        self.numberOfLines = lines
        self.textAlignment = textAlignment
        return self
    }
    
    /// 设置富文本
    ///
    /// - Parameters:
    ///   - attributedText: 富文本内容
    ///   - attributedName: 富文本的key值
    ///   - attributedValue: 富文本的value值
    ///   - location: 开始位置
    ///   - length: 长度
    @discardableResult open func ht_set(attributedText: String, attributedName: NSAttributedString.Key, attributedValue: Any, location: Int, length: Int) -> UILabel {
        let attriStr = NSMutableAttributedString(string: attributedText)
        attriStr.addAttributes([attributedName: attributedValue], range: NSRange(location: location, length: length))
        self.attributedText = attriStr
        return self
    }
    
}













