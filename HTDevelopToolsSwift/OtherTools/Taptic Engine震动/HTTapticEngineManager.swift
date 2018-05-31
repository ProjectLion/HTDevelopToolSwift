//
//  HTTapticEngineManager.swift
//  MagicSwift
//
//  Created by Ht on 2018/5/28.
//  Copyright © 2018年 secher. All rights reserved.
//

import UIKit

/// 触感反馈
class HTTapticEngineManager: NSObject {
    
    static let share = HTTapticEngineManager()
    private override init() {
        notifiGenerator.prepare()
        selectionGenerator.prepare()
    }
    
    private let notifiGenerator = UINotificationFeedbackGenerator()
    private let selectionGenerator = UISelectionFeedbackGenerator()
    
    /// 成功
    func tapticSuccese() {
        notifiGenerator.notificationOccurred(.success)
    }
    
    /// 失败
    func tapticFail() {
        notifiGenerator.notificationOccurred(.error)
    }
    
    /// 警告
    func tapticWarning() {
        notifiGenerator.notificationOccurred(.warning)
    }
    
    /// 三级震动
    func heavyImpact() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
    
    /// 二级震动
    func mediumImpact() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    /// 轻微的震动
    func lightImpact() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    /// 选中时的震动(震感最轻) 一般用于音量调节、字体大小调节等
    func selectionTaptic() {
        selectionGenerator.selectionChanged()
    }
    
}
