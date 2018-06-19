//
//  Model.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/2/25.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class Model: NSObject {
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        super.setValue(value, forUndefinedKey: key)
        print("HT------>DEBUG: 收到的key\(key)")
        print("HT------>DEBUG: 收到的value\(value)")
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
    }
    
    var id: Int = 0
    
    var desc: String = "0"{
        willSet{
            print("HT------>DEBUG: desc将要改变为\(newValue)")
        }
        didSet{
            print("HT------>DEBUG: desc已经变成\(desc)")
        }
    }
    
    var time: Float = 0.1{
        willSet{
            print("HT------>DEBUG: time将要改变为\(newValue)")
        }
        didSet{
            print("HT------>DEBUG: time已经变成\(time)")
        }
    }
    
    var isDownload: Bool = false{
        willSet{
            print("HT------>DEBUG: isDownload将要改变为\(newValue)")
        }
        didSet{
            print("HT------>DEBUG: isDownload已经变成\(isDownload)")
        }
    }
    
    struct Model_Struct {
        var ddd: String {
            return "2"
        }
        struct Model_Struct_1 {
            var aa: String = "1"
            struct Model_Struct_2 {
                var cc: Int = 2
            }
        }
    }
}
