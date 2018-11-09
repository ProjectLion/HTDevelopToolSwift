//
//  HTScreenFitSwift.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/15.
//  Copyright © 2017年 HT. All rights reserved.
//

/*
                    gitHub:https://github.com/ProjectLion/HTDevelopTool.git
                                     *              *
                                   *   *          *   *
                                  *     *        *     *
                                 *  (&)  *      *  (&)  *
                                *         *    *         *
                               联系方式:htReturnTrue@163.com
                                    *               *
                                     *             *
                                      *           *
                                       *         *
                                        *       *
                                         *     *
                                          * * *
 
 */


import Foundation
import UIKit



/// 屏幕宽
public let SCREEN_W = UIScreen.ht_screecWidth
/// 屏幕高
public let SCREEN_H = UIScreen.ht_screenHeight
/// 是否是iPhone X
public let isIphoneX = isX()
fileprivate func isX() -> Bool {
    if #available(iOS 11.0, *) {
        return (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! > 0
    } else {
        return false
    }
}
/// 经过比例适配后的宽
public func ht_W(_ w: CGFloat) -> CGFloat{
    return UIScreen.ht_setWidth(width: w)
}
/// 经过比例适配后的高
public func ht_H(_ h: CGFloat) -> CGFloat{
    return UIScreen.ht_setHeight(height: h)
}
/// 经过宽比例适配后的字体
public func ht_fontW(_ w:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: ht_W(w))
}
/// 经过高比例适配后的字体
public func ht_fontH(_ h:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: ht_H(h))
}

