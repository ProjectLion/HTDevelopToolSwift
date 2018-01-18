//
//  HTUIImageExtension.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2018/1/18.
//  Copyright © 2018年 HT. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    
    /// 将图片转为data
    ///
    /// - Parameter image: 需要转的图片
    /// - Returns: data
    func ht_transformToData() -> Data{
        if UIImagePNGRepresentation(self) != nil {
            return UIImageJPEGRepresentation(self, 1)!
        }else{
            return UIImageJPEGRepresentation(self, 0.01)!
        }
    }
    
    /// 将data数据转为Image
    ///
    /// - Parameter data: 图片数据
    /// - Returns: 获取到的图片
    func ht_getImageWith(data: Data) -> UIImage?{
        
        guard let img = UIImage(data: data) else {
            return nil
        }
        return img
    }
    
    /// 压缩图片
    ///
    /// - Returns: 压缩后的图片
    func ht_imageCut() -> UIImage{
        
//        if UIImagePNGRepresentation(self) != nil {
//            return self.ht_getImageWith(data: UIImagePNGRepresentation(self)!)!
//        }else{
//            return self.ht_getImageWith(data: UIImageJPEGRepresentation(self, 0.01)!)!
//        }
        guard UIImagePNGRepresentation(self) != nil else {
            return self.ht_getImageWith(data: UIImageJPEGRepresentation(self, 0.01)!)!
        }
        return self.ht_getImageWith(data: UIImagePNGRepresentation(self)!)!
    }
    
}


