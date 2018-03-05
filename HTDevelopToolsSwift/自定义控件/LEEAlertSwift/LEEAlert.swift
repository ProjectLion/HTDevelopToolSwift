//
//  LEEAlert.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2018/2/1.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

protocol LEEAlertDelegate{
    func closeWith(block: ()->())
}

class LEEAlert: NSObject {
    
    /// 获取单例
    static let share = LEEAlert()
    private override init() {
        
    }
    /// 初始化
    class func alert()->LEEAlertConfig{
        let config = LEEAlertConfig()
        config.type = .Alert
        return config
    }
    
    class func actionSheet()->LEEAlertConfig{
        let config = LEEAlertConfig()
        config.type = .Sheet
        config.config?.LeeClickBackgroundClose(true)
        return config
    }
    
    /// 获取主窗口
    class func getAlertWindow()->LEEAlertWindow{
        return LEEAlert.share.leeWindow
    }
    
    /// 设置主窗口
    class func configMain(window: UIWindow){
        LEEAlert.share.mainWindow = window
    }
    
    /// 继续队列显示
    class func continueQueueDisplay(){
        if LEEAlert.share.queueArray.count > 0 {
            LEEAlert.share.queueArray.last?.config?.modelFinishConfig()
        }
    }
    
    /// 清空队列
    class func clearQueue(){
        LEEAlert.share.queueArray.removeAll()
    }
    
    /// 关闭
    @objc class func closeWith(block: ()->()){
        if LEEAlert.share.queueArray.count > 0 {
            let item = LEEAlert.share.queueArray.last
            if (item?.responds(to: #selector(closeWith(block:))))!{
                item?.perform(#selector(closeWith(block:)), with: block)
            }
        }
    }
    
    var mainWindow: UIWindow?
    
//    private var 
    /**
     *   懒加载window
     */
    lazy var leeWindow: LEEAlertWindow = {
        ()->LEEAlertWindow in
        let window = LEEAlertWindow.init(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.backgroundColor = .clear
        window.windowLevel = UIWindowLevelAlert
        window.isHidden = true
        return window
    }()
    
    lazy var queueArray: Array<LEEAlertConfig> = {
        ()->Array<LEEAlertConfig> in
        let arr: [LEEAlertConfig] = []
        return arr
    }()
    
    
}

extension LEEAlert: LEEAlertDelegate{
    func closeWith(block: () -> ()) {
        
    }
}
