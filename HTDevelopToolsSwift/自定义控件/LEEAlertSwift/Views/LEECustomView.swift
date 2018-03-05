//
//  LEECustomView.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEECustomView: NSObject {
    /// 自定义视图对象
    public var view: UIView!
    
    /// 自定义视图位置 默认居中
    public var positionType: LEECustomViewPositionType = .Center
    
    /// 是否自适应宽度
    public var isAutoWidth: Bool?
    
    public var item: LEEItem!
    
    public var size: CGSize?
    
    var sizeChangedBloack: ()->Swift.Void? {
        didSet{
            guard let v = self.view else {
                return
            }
            v.layoutSubviews()
            self.size = v.frame.size
            self.view?.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        }
    }
    
    ///
    deinit {
        guard let v = self.view else {
            return
        }
        v.removeObserver(self, forKeyPath: "frame")
    }
    
    override init() {
        sizeChangedBloack = {
            return
        }
        super.init()
    }
    
    /// 添加观察
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let view = object as! UIView
        if __CGSizeEqualToSize(self.size!, view.frame.size) {
            self.size = view.frame.size
            self.sizeChangedBloack()
        }
    }
}
