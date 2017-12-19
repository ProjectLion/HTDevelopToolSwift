//
//  HTUIScreenExtension.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/15.
//  Copyright © 2017年 HT. All rights reserved.
//

import Foundation
import UIKit

extension UIScreen{
    /// 屏幕的size
    func ht_screenSize() -> CGSize{
        return self.bounds.size
    }
    /// 屏幕的宽
    func ht_screecWidth() -> CGFloat{
        return self.bounds.width
    }
    /// 屏幕的高
    func ht_screenHeight() -> CGFloat{
        return self.bounds.height
    }
    /// 适配后的宽(iPhone 6)
    class func ht_setWidth(width: CGFloat) -> CGFloat{
        return (width / 375.0) * UIScreen.main.bounds.width
    }
    /// 适配后的高(iPhone 6)
    class func ht_setHeight(height: CGFloat) -> CGFloat{
        return (height / 667.0) * UIScreen.main.bounds.height
    }
}




