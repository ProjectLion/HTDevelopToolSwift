//
//  HTMBHUDExtension.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2019/3/4.
//  Copyright © 2019 HT. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    
    /// 显示一个菊花HUD
    ///
    /// - Parameters:
    ///   - view: hud的父视图
    ///   - animated: 是否使用动画 默认true
    ///   - delayTime: 延时消失的时间 默认一秒
    /// - Returns: 实例化对象
    @discardableResult
    class func ht_show(inView view: UIView, animated: Bool = true, delayTimeOfHidden delayTime: TimeInterval = 1) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: animated)
        hud.hide(animated: animated, afterDelay: delayTime)
        return hud
    }
    
    /// 显示一个文字hud
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - view: hud的父视图
    ///   - animated: 是否使用动画
    ///   - delayTime: 延时消失的时间 默认一秒
    ///   - return: hud实例化对象
    @discardableResult
    class func ht_show(text: String, inView view: UIView, animated: Bool = true, delayTimeOfHidden delayTime: TimeInterval = 1) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: animated)
        hud.mode = .text
        hud.label.text = text
        hud.hide(animated: animated, afterDelay: delayTime)
        return hud
    }
    
}
