//
//  TestStruct.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/6/12.
//  Copyright © 2018年 HT. All rights reserved.
//

import Foundation

struct TestStruct {
    
    /// 结构体必须初始化属性的值,下面👇的写法在外部构造TestStruct时就不需要逐个赋值
    init() {  /// 自定义构造方法时需要给属性赋上初始值
    }

    var id: Int = 0

    var desc: String = "0"

    var time: Float = 0.1

    var isDownload: Bool = false
    
    /// 结构体自带构造器, 类似TestStruct(id: Int, desc: String, time: Float, isDownload: Bool, ....)
//    var id: Int
//
//    var desc: String
//
//    var time: Float
//
//    var isDownload: Bool
    
}
