//
//  LEEAlertSwiftHelper.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2018/1/22.
//  Copyright © 2018年 HT. All rights reserved.
//

import Foundation
import UIKit

///背景样式
enum LEEBackgroundStyle {
    /// 模糊
    case Blur
    /// 半透明 
    case Translucent
}

/// 屏幕方向
enum LEEScreenOrientationType {
    /// 横屏
    case Horizontal
    /// 竖屏
    case Vertical
}

/// alert类型
enum LEEAlertType {
    /// 警告提示 (居中)
    case Alert
    /// 选项表 (屏幕下方)
    case Sheet
}

/// alert按钮action类型
enum LEEActionType {
    /// 默认
    case Default
    /// 取消
    case Cancel
    /// 销毁
    case Destructive
}

/// aciton边框位置
enum LEEActionBorderPosition {
    /// 上
    case Top
    /// 下
    case Bottom
    /// 左
    case Left
    /// 右
    case Right
}

/// alert内容类型
enum LEEItemType {
    /// 标题
    case Title
    /// 详细内容
    case Content
    /// 输入框
    case TextField
    /// 自定义视图
    case CustomView
}

/// 自定义视图的位置
enum LEECustomViewPositionType {
    /// 居中
    case Center
    /// 居左
    case Left
    /// 居右
    case Right
}

/// 动画类型
enum LEEAnimatType {
    /// 默认(没有动画)
    case None
    /// 自上至下
    case Top
    /// 自下至上
    case Bottom
    /// 自左至右
    case Left
    /// 自右至左
    case Right
    /// 淡出淡入
    case Fade
    /// 放大
    case ZoomEnlarge
    /// 缩小
    case ZoomShrink
}

typealias LEEConfig = () -> LEEAlertConfigModel?
typealias LEEConfigToBool = (Bool) -> LEEAlertConfigModel?
typealias LEEConfigToInteger = (Int) -> LEEAlertConfigModel?
typealias LEEConfigToFloat = (CGFloat) -> LEEAlertConfigModel?
typealias LEEConfigToString = (String) -> LEEAlertConfigModel?
typealias LEEConfigToView = (UIView) -> LEEAlertConfigModel?
typealias LEEConfigToColor = (UIColor) -> LEEAlertConfigModel?
typealias LEEConfigToSize = (CGSize) -> LEEAlertConfigModel?
typealias LEEConfigToEdgeInsets = (inout UIEdgeInsets) -> LEEAlertConfigModel?
typealias LEEConfigToAnimationStyle = (LEEAnimatType) -> LEEAlertConfigModel?
typealias LEEConfigToBlurEffectStyle = (UIBlurEffectStyle) -> LEEAlertConfigModel?
typealias LEEConfigToInterfaceOrientationMask = (UIInterfaceOrientationMask) -> LEEAlertConfigModel?
typealias LEEConfigToFloatBlock = (@escaping (LEEScreenOrientationType) -> CGFloat) -> LEEAlertConfigModel?
typealias LEEConfigToAction = (@escaping (LEEAction) -> Swift.Void) -> LEEAlertConfigModel?
typealias LEEConfigToCustomView = (@escaping (_ custom: LEECustomView)->Swift.Void) -> LEEAlertConfigModel?
typealias LEEConfigToStringAndBlock = (String, @escaping ()->Swift.Void) -> LEEAlertConfigModel?
typealias LEEConfigToConfigLabel = (@escaping (_ label: UILabel)->Swift.Void) -> LEEAlertConfigModel?
typealias LEEConfigToConfigTextField = (@escaping (_ textField: UITextField)->Swift.Void) -> LEEAlertConfigModel?
typealias LEEConfigToItem = ((_ item:LEEItem)->Swift.Void) -> LEEAlertConfigModel?
typealias LEEConfigToBlock = (_ block: @escaping ()->Swift.Void) -> LEEAlertConfigModel?
typealias LEEConfigToBlockAndBlock = (_ block: @escaping (_ animatingBlock: AnimatingBlock, _ animatedBlock: AnimatedBlock) -> ()) -> LEEAlertConfigModel?


typealias AnimatingBlock = ()->Swift.Void
typealias AnimatedBlock = ()->Swift.Void

