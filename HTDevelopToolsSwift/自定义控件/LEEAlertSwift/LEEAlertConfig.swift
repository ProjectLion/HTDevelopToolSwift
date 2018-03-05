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
    
    public var type: LEEAlertType {
//        set{
//
//        }
//        get{
//
//        }
        didSet{
            
        }
    }
    
    override init() {
        config = LEEAlertConfigModel()
        type = .Alert
        super.init()
        
        
        config?.modelFinishConfig = ({ [weak self]
            ()->() in
            if self == nil {
                return
            }
            
            if LEEAlert.share.queueArray.count == 0 {
                let last = LEEAlert.share.queueArray.last!
                
                if self?.config?.modelIsQueue != nil && (last.config?.modelQueuePriority)! > (self?.config?.modelQueuePriority)! {
                    return
                }
                
                if last.config?.modelIsQueue != nil && ((last.config?.modelQueuePriority)! < (self?.config?.modelQueuePriority)! || (last.config?.modelQueuePriority)! == (self?.config?.modelQueuePriority)!){
                
                    LEEAlert.share.queueArray.removeLast()
                }
                
                if LEEAlert.share.queueArray.contains(self!) {
                    LEEAlert.share.queueArray.append(self!)
                    LEEAlert.share.queueArray.sort(by: { (configA, configB) -> Bool in
                        if (configA.config?.modelQueuePriority)! > (configB.config?.modelQueuePriority)! {
                            return true
                        }else{
                            return (configA.config?.modelQueuePriority)! == (configB.config?.modelQueuePriority)! ? false : true
                        }
                    })
                }
                
                if LEEAlert.share.queueArray.last == self {
//                    self.show()
                }
                
            } else {
//                self.show()
                LEEAlert.share.queueArray.append(self!)
            }
        })
    }
    
    deinit {
        self.config = nil
    }
    
}


    
extension LEEAlertConfig: LEEAlertDelegate {
    
    func closeWith(block: () -> ()) {
        
    }
    
}
