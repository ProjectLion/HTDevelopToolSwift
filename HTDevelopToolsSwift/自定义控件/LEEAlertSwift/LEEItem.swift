//
//  LEEItem.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2018/1/22.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEEItem: NSObject {
    
    /// item类型
    public var type: LEEItemType = .Title
    
    /// item偏移量(间距)
    public var insets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    
    /// item设置视图回调
    public var viewBlock: (_ view: Any) -> () = {
        view in
        
    }
    let m = LEEAlertConfigModel()
    
    /// 刷新
    public func update(){
        self.updateBlock(self)
        
    }
    
    private let updateBlock: (_ item: LEEItem) ->() = {
        item in
        
    }
}
