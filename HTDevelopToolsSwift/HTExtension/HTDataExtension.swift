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
    
    /// 将data数据转为Image
    ///
    /// - Parameter data: 图片数据
    /// - Returns: 获取到的图片
    func ht_getImageWith() -> UIImage?{
        
        guard let img = UIImage(data: self) else {
            return nil
        }
        return img
    }
    
}




