//
//  HTDataExtension.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/15.
//  Copyright © 2017年 HT. All rights reserved.
//

import Foundation
import UIKit

extension Data{
    
    /// 将图片转为data
    ///
    /// - Parameter image: 需要转的图片
    /// - Returns: data
    static func ht_dataWith(image: UIImage) -> Data{
        var data = Data()
        if UIImagePNGRepresentation(image) != nil {
            data = UIImageJPEGRepresentation(image, 1)!
        }else{
            data = UIImageJPEGRepresentation(image, 0.01)!
        }
        return data
    }
}




