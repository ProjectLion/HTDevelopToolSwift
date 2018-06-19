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
    convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, style: UIButton.ButtonType){
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
    class func ht_init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, style: UIButton.ButtonType) -> UIButton{
        let btn = UIButton(type: style)
        btn.frame = CGRect(x: x, y: y, width: width, height: height)
        return btn
    }
    
    /// 利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
    ///
    /// - Parameters:
    ///   - imgPointStyle: 图片的位置风格
    ///   - spaceing: 间距(如果间距+图片大小+titleLabel大小 超过按钮本身大小,则自动缩小间距)
    public func ht_set(imgPointStyle: ButtonImagePoint, spaceing: CGFloat) {
        
        let imgH = self.imageView?.bounds.height
        let imgW = self.imageView?.bounds.width
        
        let labelH = (self.titleLabel?.text as NSString?)?.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel?.font as Any]).height
        let labelW = (self.titleLabel?.text as NSString?)?.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel?.font as Any]).width
        
        var tempSpace = spaceing
        
        switch imgPointStyle {
        case .top, .bottom:
            if imgH! + labelH! + spaceing > self.frame.size.height {
                tempSpace = self.frame.size.height - imgH! - labelH!
            }
        case .left, .right:
            if imgW! + labelW! + spaceing > self.frame.size.width {
                tempSpace = self.frame.size.width - imgW! - labelW!
            }
        }
        
        if tempSpace < 0 {
            tempSpace = 0
        }
        
        let imgOffsetX = (imgW! + labelW!) / 2 - imgW! / 2
        let imgOffsetY = (imgH! + labelH!) / 2 - imgH! / 2
        let labelOffsetX = (imgW! + labelW!) / 2 - (labelW!) / 2
        let labelOffsetY = (imgH! + labelH!) / 2 - labelH! / 2 + tempSpace
        
        switch imgPointStyle {
            
        case .top:
            self.imageEdgeInsets = UIEdgeInsets(top: -imgOffsetY, left: imgOffsetX, bottom: imgOffsetY, right: -imgOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
        case .bottom:
            self.imageEdgeInsets = UIEdgeInsets(top: imgOffsetY, left: imgOffsetX, bottom: -imgOffsetY, right: -imgOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX, bottom: labelOffsetY, right: labelOffsetX)
        case .left:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -tempSpace / 2, bottom: 0, right: tempSpace / 2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: tempSpace / 2, bottom: 0, right: -tempSpace / 2)
        case .right:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelW! + tempSpace / 2, bottom: 0, right: -(labelW! + tempSpace / 2))
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imgH! + tempSpace / 2), bottom: 0, right: imgH! + tempSpace / 2)
        }
        
    }
    
    /// 设置按钮标题
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 字体
    ///   - color: 字体色
    ///   - state: 状态
    public func ht_set(title: String, font: UIFont, color: UIColor, state: UIControl.State) {
        
        self.setTitle(title, for: state)
        self.setTitleColor(color, for: state)
        self.titleLabel?.font = font
        
    }
    
    /// 设置按钮背景色
    ///
    /// - Parameters:
    ///   - backGroundColor: 背景色
    ///   - state: 状态
    public func ht_set(backGroundColor: UIColor, state: UIControl.State) {
        self.adjustsImageWhenHighlighted = false
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backGroundColor.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(img, for: state)
    }
    
}





















