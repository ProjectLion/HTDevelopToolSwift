//
//  LEEAlertConfig.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/2/1.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEEAlertConfig: NSObject {
    
    public var config: LEEAlertConfigModel?
    
    public var type: LEEAlertType?
    
    override init() {
        config = LEEAlertConfigModel()
        type = .Alert
        super.init()
        
        config?.modelFinishConfig = ({ [weak self]
            ()->() in
            
        })
    }
    
}
