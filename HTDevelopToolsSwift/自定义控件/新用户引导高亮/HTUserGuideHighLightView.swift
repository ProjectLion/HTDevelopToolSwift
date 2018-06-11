//
//  HTUserGuideHighLightView.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/5/31.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

public enum HTUserGuideStyle {
    /// 正方形
    case square
    /// 长方形
    case rectangle
    /// 椭圆
    case ellipse
    /// 圆形
    case circle
    /// 其他
    case other
}

class HTUserGuideHighLightView: UIView {
    
    /// 灰色部分的透明度
    open var grayAlpha: CGFloat = 0.4 {
        didSet {
            self.alpha = grayAlpha
        }
    }
    /// 高亮部分的风格
//    open var style: HTUserGuideStyle {
//        didSet {
//
//        }
//    }
    
    
    private var selfStyle: HTUserGuideStyle = .rectangle
    
    convenience init(lightFrame: CGRect) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//MARK: ^^^^^^^^^^^^^^^ 公开的属性 ^^^^^^^^^^^^^^^
extension HTUserGuideHighLightView {
    
}
