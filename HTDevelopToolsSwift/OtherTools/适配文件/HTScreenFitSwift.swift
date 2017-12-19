//
//  HTScreenFitSwift.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/15.
//  Copyright © 2017年 HT. All rights reserved.
//

import Foundation
import UIKit



/// 屏幕宽
let SCREEN_W = UIScreen.main.bounds.width
/// 屏幕高
let SCREEN_H = UIScreen.main.bounds.height
/// 是否是iPhone X
let isIphoneX = ((SCREEN_W == 375.0 && SCREEN_H == 812.0) ? true : false)
/// 经过比例适配后的宽
public func ht_W(_ w: CGFloat) -> CGFloat{
    return (w / 375.0) * UIScreen.main.bounds.width
}
/// 经过比例适配后的高
public func ht_H(_ h: CGFloat) -> CGFloat{
    return (h / 667.0) * UIScreen.main.bounds.height
}
/// 经过宽比例适配后的字体
public func ht_fontW(_ w:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: ht_W(w))
}
/// 经过高比例适配后的字体
public func ht_fontH(_ h:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: ht_H(h))
}
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


