//
//  LEEAlertConfigModel.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2018/1/22.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEEAlertConfigModel: NSObject {
    
    public var modelActionArray: [Any]?
    public var modelItemArray: [Any]?
    public var modelItemInsetsInfo: Dictionary<String, Any>?
    
    public var modelCornerRadius: CGFloat?                   // 圆角半径 默认13.0
    public var modelShadowOpacity: CGFloat?                  // 阴影透明度 默认0.3
    public var modelShadowRadius: CGFloat?                   // 默认阴影半径 默认5.0
    public var modelOpenAnimationDuration: CGFloat?           // 弹出动画时间 默认0.35
    public var modelCloseAnimationDuration: CGFloat?          // 消失动画时间 默认0.35
    public var modelBackgroundStyleColorAlpha: CGFloat?      // 背景透明度 默认0.45
    public var modelWindowLevel: UIWindowLevel?              // window等级 默认alert
    public var modelQueuePriority: Int?                      // 队列优先级 默认0
    
    public var modelShadowColor: UIColor?                    // 阴影颜色 默认黑色
    public var modelHeaderColor: UIColor?                    // 顶部视图颜色 默认白色
    public var modelBackgroundColor: UIColor?                // 控件背景色 默认白色
    
    public var modelIsClickHeaderClose: Bool?                // 是否可以点击顶部关闭窗口 默认false
    public var modelIsClickBackgroundClose: Bool?            // 是否可以点击背景关闭窗口 默认true
    public var modelIsShouldAutorotate: Bool?                // 是否可以自转 默认false
    public var modelIsQueue: Bool?                           // 是否加入队列 默认false
    public var modelIsContinueQueueDisplay: Bool?            // 是否按照队列显示 默认true
    public var modelIsAvoidKeyboard: Bool?                   // 是否规避键盘 默认true
    
    public var modelShadowOffset: CGSize?                    // 阴影大小
    public var modelHeaderInsets: UIEdgeInsets?              // 顶部视图偏移量 默认 top 5,bottom 5,left、right 0
    
    public var modelIdentifier: String?                      // 标识符 默认为""
    
    public var modelMaxWidthBlock: (LEEScreenOrientationType)->(CGFloat)?
    public var modelMaxHeightBlock: (LEEScreenOrientationType)->(CGFloat)?
    
    // 开启动画时间回调
    public var modelOpenAnimationBlock: (_ animating: @escaping ()->Swift.Void,_ animated: @escaping ()->Swift.Void)->Swift.Void?
    public var modelCloseAnimationBlock: (_ animating: @escaping ()->Swift.Void,_ animated: @escaping ()->Swift.Void)->Swift.Void?
    public var modelFinishConfig: ()->Swift.Void?
    public var modelCloseComplete: ()->Swift.Void?
    
    public var modelBackgroundStyle: LEEBackgroundStyle?             // 背景风格 默认半透明
    public var modelOpenAnimationStyle: LEEAnimatType?               // 开启动画风格 默认淡入
    public var modelCloseAnimationStyle: LEEAnimatType?              // 关闭动画风格 默认淡出
    
    public var modelBackgroundBlurEffectStyle: UIBlurEffectStyle?    // 背景模糊风格 默认灰色
    public var modelSupportedInterfaceOrientations: UIInterfaceOrientationMask?  ///
    
    public var modelSheetCancelSpaceColor: UIColor?                  // sheet取消按钮间距颜色 默认白色
    public var modelSheetCancelSpaceHeight: CGFloat?                 // sheet取消按钮间距 默认10.0
    public var modelSheetBottomMargin: CGFloat?                      // sheet底部距屏幕底部宽度 默认10.0
    
    override init() {
        
        modelMaxWidthBlock = {
            (type: LEEScreenOrientationType)->(CGFloat) in
            if type == .Horizontal {
                return 0.1
            }else{
                return 0.2
            }
            
        }
        modelMaxHeightBlock = {
            (type: LEEScreenOrientationType)->(CGFloat) in
            if type == .Vertical {
                return 0.1
            }else{
                return 0.3
            }
        }
        modelOpenAnimationBlock = {
            (_ animating: @escaping ()->Swift.Void,_ animated: @escaping ()->Swift.Void)->Swift.Void in
        }
        modelCloseAnimationBlock = {
            (_ animating: @escaping ()->Swift.Void,_ animated: @escaping ()->Swift.Void)->Swift.Void in
        }
        
        modelFinishConfig = {
            ()->() in
        }
        modelCloseComplete = {
            ()->() in 
        }
        super.init()
        // 初始化默认值
        
        modelCornerRadius = 13.0         //默认圆角半径
        modelShadowOpacity = 0.3         //默认阴影不透明度
        modelShadowRadius = 5.0          //默认阴影半径
        modelShadowOffset = CGSize.init(width: 0.0, height: 2.0)    //默认阴影偏移
        modelHeaderInsets = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)     //默认间距
        modelOpenAnimationDuration = 0.3    //默认打开动画时长
        modelCloseAnimationDuration = 0.2   //默认关闭动画时长
        modelBackgroundStyleColorAlpha = 0.45   //自定义背景样式颜色透明度 默认为半透明背景样式 透明度为0.45f
        modelWindowLevel = UIWindowLevelAlert
        modelQueuePriority = 0              //默认队列优先级 (大于0时才会加入队列)
        
        
        modelSheetCancelSpaceColor = .clear             //默认actionsheet取消按钮间隔颜色
        modelSheetCancelSpaceHeight = 10.0              //默认actionsheet取消按钮间隔宽度
        modelSheetBottomMargin = 10.0                   //默认actionsheet距离屏幕底部距离
        
        modelShadowColor = .black                       //默认阴影颜色
        modelHeaderColor = .white                       //默认颜色
        modelBackgroundColor = .black                   //默认背景半透明颜色
        
        modelIsClickBackgroundClose = false             //默认点击背景不关闭
        modelIsShouldAutorotate = true                  //默认支持自动旋转
        modelIsQueue = false                            //默认不加入队列
        modelIsContinueQueueDisplay = true              //默认继续队列显示
        modelIsAvoidKeyboard = true                     //默认闪避键盘
        
        modelBackgroundStyle = .Translucent;            //默认为半透明背景样式
        
        modelBackgroundBlurEffectStyle = .dark;         //默认模糊效果类型Dark
        modelSupportedInterfaceOrientations = .all      //默认支持所有方向
        
        
        modelOpenAnimationBlock = {
            [weak self]
            ///逃逸闭包 明确的知道两个逃逸闭包参数要做什么
            (animating: @escaping ()->Swift.Void,animated: @escaping ()->Swift.Void)->Swift.Void in
            
            UIView.animate(withDuration: TimeInterval(self!.modelOpenAnimationDuration!), delay: 0, options: .curveEaseOut, animations: {
                animating()
            }, completion: { (finished) in
                if finished {
                    animated()
                }
            })
            
        }
        modelCloseAnimationBlock = {
            [weak self]
            ///逃逸闭包 明确的知道两个逃逸闭包参数要做什么
            (animating: @escaping ()->Swift.Void, animated: @escaping ()->Swift.Void)->Swift.Void in
            
            UIView.animate(withDuration: TimeInterval(self!.modelCloseAnimationDuration!), delay: 0, options: .curveEaseOut, animations: {
                animating()
            }, completion: { (finished) in
                if finished {
                    animated()
                }
            })
            
        }
    }
    /// 消失不用时将数组和数据字典置为空
    deinit {
        modelActionArray = nil
        modelItemArray = nil
        modelItemInsetsInfo = nil
    }
}

extension LEEAlertConfigModel {
    
    //          公开给外部自定义的设置接口        //
    
//    /// 消除警告
//    public var LeeRemoveWarning:LEEConfigToBool {
//        get{
//            return {
//                (_ bl: Bool)->LEEAlertConfigModel in
//                return
//            }
//        }
//    }
    
    /// 添加item
    public var LeeAddItem: LEEConfigToItem {
        get{
            return { [weak self]
                (block:(_ item: LEEItem)->Swift.Void)->LEEAlertConfigModel in
                if (self != nil) {
                    self?.modelItemArray?.append(block)
                }
                return self!
            }
        }
    }
    
    /// 添加title
    public var LeeAddTitle: LEEConfigToConfigLabel {
        get{
            return { [weak self]
                (block: @escaping (_ label: UILabel)->Swift.Void)->LEEAlertConfigModel in
                return self!.LeeAddItem({ item in
                    item.type = .Title
                    item.insets = UIEdgeInsetsMake(5, 0, 5, 0)
                    item.viewBlock = block as! (Any) -> ()
                })!
            }
        }
    }
    
    ///添加content
    public var LeeAddContent: LEEConfigToConfigLabel {
        get{
            return { [weak self]
                (block: @escaping (_ label: UILabel)->Swift.Void)->LEEAlertConfigModel in
                return self!.LeeAddItem({ item in
                    item.type = .Content
                    item.insets = UIEdgeInsetsMake(5, 0, 5, 0)
                    item.viewBlock = block as! (Any) -> ()
                })!
            }
        }
    }
    /// 添加自定义视图
    public var LeeAddCustomView: LEEConfigToCustomView {
        get{
            return { [weak self]
                (block: @escaping(_ custom: LeeCustomView)->Swift.Void)->LEEAlertConfigModel in
                return (self?.LeeAddItem({ item in
                    item.type = .CustomView
                    item.insets = UIEdgeInsetsMake(5, 0, 5, 0)
                    item.viewBlock = block as! (Any) -> ()
                }))!
                }

        }
    }
    
    /// 添加action
    public var LeeAddAction: LEEConfigToAction {
        get{
            return { [weak self]
                (block: @escaping (_ action: LEEAction)->Swift.Void)->LEEAlertConfigModel in
                self?.modelActionArray?.append(block)
                return self!
            }
        }
    }
    
    /// 设置标题
    public var LeeTitle: LEEConfigToString {
        get{
            return { [weak self]
                (str: String) -> LEEAlertConfigModel  in
                
                return (self?.LeeAddTitle({ (label) in
                    label.text = str
                }))!
                
            }
        }
    }

    /// 设置内容
    public var LeeContent: LEEConfigToString {
        get{
            return { [weak self]
                (str: String) -> LEEAlertConfigModel in
                return (self?.LeeAddContent({ (label) in
                    label.text = str
                }))!
            }
        }
    }

    /// 自定义视图
    public var LeeCustomView: LEEConfigToView {
        get{
            return { [weak self]
                (view: UIView) -> LEEAlertConfigModel in
                return (self?.LeeAddCustomView({ (custom) in
                    custom.view = view
                    custom.positionType = .Center
                }))!
            }
        }
    }

    /// 动作action
    public var LeeAction: LEEConfigToStringAndBlock {
        get{
            return { [weak self]
                (_ title: String, block: @escaping ()->Swift.Void)->LEEAlertConfigModel in
                return (self?.LeeAddAction({ (action) in
                    action.type = .Default
                    action.title = title
                    action.clickBlock = block
                }))!
            }
        }
    }

    /// 取消动作
    public var LeeCancelAction: LEEConfigToStringAndBlock {
        get{
            return { [weak self]
                (title: String,block: @escaping ()->Swift.Void)->LEEAlertConfigModel in
                return (self?.LeeAddAction({ (action) in
                    action.type = .Cancel
                    action.title = title
                    action.font = UIFont.boldSystemFont(ofSize: 18.0)
                    action.clickBlock = block
                }))!
            }
        }
    }

    /// 销毁动作
    public var LeeDestructiveAction: LEEConfigToStringAndBlock {
        get{
            return { [weak self]
                (title: String,block: @escaping ()->Swift.Void)->LEEAlertConfigModel in
                return (self?.LeeAddAction({ (action) in
                    action.type = .Destructive
                    action.title = title
                    action.titleColor = .red
                    action.clickBlock = block
                }))!
            }
        }
    }
    
    /// 顶部视图偏移量
    public var LeeHeaderInsets: LEEConfigToEdgeInsets {
        get{
            return { [weak self]
                (insets: inout UIEdgeInsets)->LEEAlertConfigModel in
                if self != nil {
                    if insets.top < 0 { insets.top = 0 }
                    if insets.bottom < 0 { insets.bottom = 0 }
                    if insets.left < 0 { insets.left = 0 }
                    if insets.right < 0 { insets.right = 0 }
                    self?.modelHeaderInsets = insets
                }
                return self!
            }
        }
    }
    
    /// item偏移量
    public var LeeItemInsets: LEEConfigToEdgeInsets {
        get{
            return { [weak self]
                (insets: inout UIEdgeInsets)->LEEAlertConfigModel in
                if self != nil {
                    if (self?.modelItemArray?.count)! > 0 {
                        if insets.top < 0 { insets.top = 0 }
                        if insets.bottom < 0 { insets.bottom = 0 }
                        if insets.left < 0 { insets.left = 0 }
                        if insets.right < 0 { insets.right = 0 }
                        self?.modelItemInsetsInfo?.updateValue(NSValue.init(uiEdgeInsets: insets), forKey: "\((self?.modelItemArray!.count)! - 1)")
                    }else{
                        print("DEBUG: 请在添加的某一项后面设置间距")
                    }
                    
                    
                }
                return self!
            }
        }
    }
    
    /// 配置最大宽度
    public var LeeConfigMaxWidth: LEEConfigToFloatBlock {
        
        get{
            return { [weak self]
                (block: @escaping (_ type: LEEScreenOrientationType)->CGFloat)->LEEAlertConfigModel in
                self?.modelMaxWidthBlock = block
                return self!
            }
        }
        
    }
    
    /// 设置最大宽度
    public var LeeMaxWidth: LEEConfigToFloat {
        get{
            return { [weak self]
                (number: CGFloat)->LEEAlertConfigModel in
                return (self?.LeeConfigMaxWidth({ type -> CGFloat in
                    return number
                }))!
            }
        }
    }
    
    /// 配置最大高度
    public var LeeConfigMaxHeight: LEEConfigToFloatBlock{
        get {
            return { [weak self]
                (block: @escaping (_ type: LEEScreenOrientationType)->CGFloat)->LEEAlertConfigModel in
                self?.modelMaxHeightBlock = block
                return self!
            }
        }
    }
    
    /// 设置最大高度
    public var LeeMaxHeight: LEEConfigToFloat {
        get{
            return { [weak self]
                (number: CGFloat)->LEEAlertConfigModel in
                return (self?.LeeConfigMaxHeight({ type -> CGFloat in
                    return number
                }))!
            }
        }
    }
    
    /// 设置圆角半径
    public var LeeCornerRadius: LEEConfigToFloat {
        get{
            return { [weak self]
                (radius: CGFloat)->LEEAlertConfigModel in
                self?.modelCornerRadius = radius
                return self!
            }
        }
    }
    
    /// 设置动画开启时间
    public var LeeOpenAnimationDuration: LEEConfigToFloat {
        get{
            return { [weak self]
                (duration: CGFloat)->LEEAlertConfigModel in
                self?.modelOpenAnimationDuration = duration
                return self!
            }
        }
    }
    
    /// 设置动画关闭时间
    public var LeeCloseAnimationDuration: LEEConfigToFloat {
        get{
            return { [weak self]
                (duration: CGFloat)->LEEAlertConfigModel in
                self?.modelCloseAnimationDuration = duration
                return self!
            }
        }
    }
    
    /// 设置头部View颜色
    public var LeeHeaderColor: LEEConfigToColor {
        get{
            return { [weak self]
                (color: UIColor)->LEEAlertConfigModel in
                self?.modelHeaderColor = color
                return self!
            }
        }
    }
    
    /// 设置背景颜色
    public var LeeBackGroundColor: LEEConfigToColor{
        get{
            return { [weak self]
                (color: UIColor)->LEEAlertConfigModel in
                self?.modelBackgroundColor = color
                return self!
            }
        }
    }
    
    /// 设置为半透明背景样式及透明度
    public var LeeBackgroundStyleTranslucent: LEEConfigToFloat{
        get{
            return { [weak self]
                (alpha: CGFloat)->LEEAlertConfigModel in
                self?.modelBackgroundStyle = .Translucent
                self?.modelBackgroundStyleColorAlpha = alpha
                return self!
            }
        }
    }
    
    /// 设置为模糊背景样式及类型
    public var LeeBackgroundStyleBlur: LEEConfigToBlurEffectStyle{
        get{
            return { [weak self]
                (style: UIBlurEffectStyle)->LEEAlertConfigModel in
                self?.modelBackgroundStyle = .Blur
                self?.modelBackgroundBlurEffectStyle = style
                return self!
            }
        }
    }
    
    /// 设置点击头部关闭
    public var LeeClickHeaderClose: LEEConfigToBool{
        get{
            return { [weak self]
                (isClose: Bool)->LEEAlertConfigModel in
                self?.modelIsClickHeaderClose = isClose
                return self!
            }
        }
    }
    
    /// 设置点击背景关闭
    public var LeeClickBackgroundClose: LEEConfigToBool{
        get{
            return { [weak self]
                (isClose: Bool)->LEEAlertConfigModel in
                self?.modelIsClickBackgroundClose = isClose
                return self!
            }
        }
    }
    
    /// 设置阴影偏移量
    public var LeeShadowOffset: LEEConfigToSize{
        get{
            return { [weak self]
                (size: CGSize)->LEEAlertConfigModel in
                self?.modelShadowOffset = size
                return self!
            }
        }
    }
    
    /// 设置阴影透明度
    public var LeeShadowOpacity: LEEConfigToFloat{
        get{
            return { [weak self]
                (opacity: CGFloat)->LEEAlertConfigModel in
                self?.modelShadowOpacity = opacity
                return self!
            }
        }
    }
    
    /// 设置阴影半径
    public var LeeShadowRadius: LEEConfigToFloat{
        get{
            return { [weak self]
                (radius: CGFloat)->LEEAlertConfigModel in
                self?.modelShadowRadius = radius
                return self!
            }
        }
    }
    
    /// 设置阴影颜色
    public var LeeShadowColor: LEEConfigToColor{
        get{
            return { [weak self]
                (color: UIColor)->LEEAlertConfigModel in
                self?.modelShadowColor = color
                return self!
            }
        }
    }
    
    /// 设置是否加入队列
    public var LeeQueue: LEEConfigToBool{
        get{
            return { [weak self]
                (isQueue: Bool)->LEEAlertConfigModel in
                self?.modelIsQueue = isQueue
                return self!
            }
        }
    }
    
    /// 设置优先级
    public var LeePriority: LEEConfigToInteger{
        get{
            return { [weak self]
                (priority: Int)->LEEAlertConfigModel in
                self?.modelQueuePriority = priority
                return self!
            }
        }
    }
    
    /// 设置是否继续队列显示
    public var LeeContinueQueueDisplay: LEEConfigToBool{
        get{
            return { [weak self]
                (isDisplay: Bool)->LEEAlertConfigModel in
                self?.modelIsContinueQueueDisplay = isDisplay
                return self!
            }
        }
    }
    
    /// 设置window等级
    public var LeeWindowLevel: LEEConfigToFloat{
        get{
            return { [weak self]
                (level: CGFloat)->LEEAlertConfigModel in
                self?.modelWindowLevel = level
                return self!
            }
        }
    }
    
    /// 设置是否支持自动旋转
    public var LeeShouldAutorotate: LEEConfigToBool{
        get{
            return { [weak self]
                (isAutorotate: Bool)->LEEAlertConfigModel in
                self?.modelIsShouldAutorotate = isAutorotate
                return self!
            }
        }
    }
    
    /// 设置是否支持显示方向
    public var LeeSupportedInterfaceOrientations: LEEConfigToInterfaceOrientationMask{
        get{
            return { [weak self]
                (mask: UIInterfaceOrientationMask)->LEEAlertConfigModel in
                self?.modelSupportedInterfaceOrientations = mask
                return self!
            }
        }
    }
    
    /// 打开动画配置
    public var LeeOpenAnimationConfig: LEEConfigToBlockAndBlock{
        get{
            return { [weak self]
                (_ block: @escaping (_ animatingBlock: AnimatingBlock, _ animatedBlock: AnimatedBlock) -> ())->LEEAlertConfigModel in
                self?.modelOpenAnimationBlock = block
                return self!
                }
        }
    }
    
    /// 关闭动画配置
    public var LeeCloseAnimationConfig: LEEConfigToBlockAndBlock{
        get{
            return { [weak self]
                (_ block: @escaping (_ animatingBlock: AnimatingBlock, _ animatedBlock: AnimatedBlock) -> ())->LEEAlertConfigModel in
                self?.modelCloseAnimationBlock = block
                return self!
            }
        }
    }
    
    /// 设置打开动画样式
    public var LeeOpenAnimationStyle: LEEConfigToAnimationStyle{
        get{
            return { [weak self]
                (style: LEEAnimatType)->LEEAlertConfigModel in
                self?.modelOpenAnimationStyle = style
                return self!
            }
        }
    }
    
    /// 设置关闭动画样式
    public var LeeCloseAnimationStyle: LEEConfigToAnimationStyle{
        get{
            return { [weak self]
                (style: LEEAnimatType)->LEEAlertConfigModel in
                self?.modelCloseAnimationStyle = style
                return self!
            }
        }
    }
    
    /// 显示
    public var LeeShow: LEEConfig{
        get{
            return { [weak self]
                ()->LEEAlertConfigModel in
                self?.modelFinishConfig()
                return self!
            }
        }
    }
    
    /**
     *   alert设置
     */
    /// 添加输入框
    public var LeeAddTextField: LEEConfigToConfigTextField{
        get{
            return { [weak self]
                (_ block: @escaping (UITextField)->())->LEEAlertConfigModel in
                return (self?.LeeAddItem({ (item) in
                    item.type = .TextField
                    item.insets = UIEdgeInsetsMake(10, 0, 10, 0)
                    item.viewBlock = block as! (UIView) -> ()
                }))!
            }
        }
    }
    
    /// 设置是否规避键盘
    public var LeeAvoidKeyboard: LEEConfigToBool{
        get{
            return { [weak self]
                (isAvoid: Bool)->LEEAlertConfigModel in
                self?.modelIsAvoidKeyboard = isAvoid
                return self!
            }
        }
    }
    
    /**
     *   actionSheet设置
     */
    /// 设置取消按钮的间隔
    public var LeeSheetCancelSpaceHeight: LEEConfigToFloat{
        get{
            return { [weak self]
                (space: CGFloat)->LEEAlertConfigModel in
                self?.modelSheetCancelSpaceHeight = space
                return self!
            }
        }
    }
    
    /// 设置取消按钮的间隔颜色
    public var LeeSheetCancelSpaceColor: LEEConfigToColor{
        get{
            return { [weak self]
                (color: UIColor)->LEEAlertConfigModel in
                self?.modelSheetCancelSpaceColor = color
                return self!
            }
        }
    }
    
    /// 设置actionSheet距屏幕底部的间距
    public var LeeSheetBottomMargin: LEEConfigToFloat{
        get{
            return { [weak self]
                (margin: CGFloat)->LEEAlertConfigModel in
                self?.modelSheetBottomMargin = margin
                return self!
            }
        }
    }
    
    /// 关闭当前回调
    public var LeeCloseComplete: LEEConfigToBlock{
        get{
            return { [weak self]
                (_block: @escaping ()->())->LEEAlertConfigModel in
                self?.modelCloseComplete = _block
                return self!
            }
        }
    }
    /************************************************************/
}















