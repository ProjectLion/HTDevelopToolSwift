//
//  LEEItemTextField.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEEItemTextField: UITextField {
    
    public var item: LEEItem!
    
    class func textField() -> LEEItemTextField {
        return LEEItemTextField(frame: .zero)
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
