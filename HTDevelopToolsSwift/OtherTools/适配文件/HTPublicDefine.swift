//
//  HTPublicDefine.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/6/19.
//  Copyright © 2018年 HT. All rights reserved.
//

import Foundation
import UIKit


/// 使用RGB数值初始化一个颜色
public func ht_color(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor{
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
}
/// 将十六进制转为UIColor
public func ht_colorWith(hexValue: Int) -> UIColor{
    
    return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                   alpha: 1.0)
}

/// Debug输出
public func ht_print<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("这里是\((file as NSString).lastPathComponent)文件的第\(line)行,\(method)方法,logMessage: \(message)")
    #endif
}
