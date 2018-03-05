//
//  HTUIButtonExtension.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/2/27.
//  Copyright © 2018年 HT. All rights reserved.
//

import Foundation
import UIKit

public enum ButtonImagePoint {
    case top
    case bottom
    case left
    case right
}

/**
 *   properties
 */
extension UIButton {
    
    
}
/**
 *   Method
 */
extension UIButton {
    
    
    /// 创建一个按钮
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - width: 宽
    ///   - height: 高
    convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, style: UIButtonType){
        self.init(type: style)
        self.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    /// 创建一个按钮
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - width: 宽
    ///   - height: 高
    ///   - style: 按钮类型
    /// - Returns: 按钮
    class func ht_init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, style: UIButtonType) -> UIButton{
        let btn = UIButton(type: style)
        btn.frame = CGRect(x: x, y: y, width: width, height: height)
        return btn
    }
    
    /// 利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
    ///
    /// - Parameters:
    ///   - imgPointStyle: 图片的位置风格
    ///   - spaceing: 间距
    public func ht_set(imgPointStyle: ButtonImagePoint, spaceing: CGFloat) {
        
        let imgH = self.imageView?.bounds.height
        let imgW = self.imageView?.bounds.width
        
        let labelH = (self.titleLabel?.text as NSString?)?.size(withAttributes: [NSAttributedStringKey.font: self.titleLabel?.font as Any]).height
        let labelW = (self.titleLabel?.text as NSString?)?.size(withAttributes: [NSAttributedStringKey.font: self.titleLabel?.font as Any]).width
        
        let imgOffsetX = (imgW! + labelW!) / 2 - imgW! / 2
        let imgOffsetY = (imgH! + labelH!) / 2 - imgH! / 2
        let labelOffsetX = (imgW! + labelW!) / 2 - (imgW! + labelW!) / 2
        let labelOffsetY = labelH! / 2 + spaceing / 2
        
        switch imgPointStyle {
            
        case .top:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imgOffsetY, imgOffsetX, imgOffsetY, -imgOffsetX)
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX)
        case .bottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imgOffsetY, imgOffsetX, -imgOffsetY, -imgOffsetX)
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX)
        case .left:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spaceing / 2, 0, spaceing / 2)
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spaceing / 2, 0, -spaceing / 2)
        case .right:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelW! + spaceing / 2, 0, -(labelW! + spaceing / 2))
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgH! + spaceing / 2), 0, imgH! + spaceing / 2)
        }
        
    }
    
    /// 设置按钮标题
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 字体
    ///   - color: 字体色
    ///   - state: 状态
    public func ht_set(title: String, font: UIFont, color: UIColor, state: UIControlState) {
        
        self.setTitle(title, for: state)
        self.setTitleColor(color, for: state)
        self.titleLabel?.font = font
        
    }
    
    /// 设置按钮背景色
    ///
    /// - Parameters:
    ///   - backGroundColor: 背景色
    ///   - state: 状态
    public func ht_set(backGroundColor: UIColor, state: UIControlState) {
        
        let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backGroundColor.cgColor)
        context?.addRect(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setImage(img, for: state)
    }
    
}





















