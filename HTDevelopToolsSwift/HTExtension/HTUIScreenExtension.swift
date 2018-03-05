//
//  HTUIScreenExtension.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/15.
//  Copyright © 2017年 HT. All rights reserved.
//

import Foundation
import UIKit

public extension UIScreen{
    
    /// 屏幕的size
    static var ht_screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    /// 屏幕的宽
    static var ht_screecWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// 屏幕的高
    static var ht_screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
//    /// 屏幕的size
//    class func ht_screenSize() -> CGSize{
//        return UIScreen.main.bounds.size
//    }
//    /// 屏幕的宽
//    class func ht_screecWidth() -> CGFloat{
//        return UIScreen.main.bounds.width
//    }
//    /// 屏幕的高
//    class func ht_screenHeight() -> CGFloat{
//        return UIScreen.main.bounds.height
//    }
    /// 适配后的宽(iPhone 6)
    class func ht_setWidth(width: CGFloat) -> CGFloat{
        return (width / 375.0) * UIScreen.ht_screecWidth
    }
    /// 适配后的高(iPhone 6)
    class func ht_setHeight(height: CGFloat) -> CGFloat{
        return (height / 667.0) * UIScreen.ht_screenHeight
    }
}




