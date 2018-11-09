//
//  HTXIBExtension.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/9/10.
//  Copyright © 2018年 HT. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// 圆角
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            if newValue > 0 {
                layer.masksToBounds = true
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    
    /// 边框宽
    @IBInspectable public var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    /// 边框颜色
    @IBInspectable public var borderColor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
    }
}

/// 系统约束的拓展，方便在使用xib拖拽UI时进行屏幕尺寸比例适配(iPhone 6)
extension NSLayoutConstraint {
    
    @IBInspectable public var adapterScreen: Bool {
        set {
            if newValue {
                constant = constant * (SCREEN_W / 375)
            }
        }
        get {
            return true
        }
    }
    
    @IBInspectable public var fitNavHeight: Bool {
        set {
            if newValue {
                if isIphoneX {
                    constant = constant + 24
                }
            }
        }
        get {
            return false
        }
    }
    
    @IBInspectable public var fitTabBar: Bool {
        set {
            if newValue {
                if isIphoneX {
                    constant = constant + 34
                }
            }
        }
        get {
            return false
        }
    }
    
}
