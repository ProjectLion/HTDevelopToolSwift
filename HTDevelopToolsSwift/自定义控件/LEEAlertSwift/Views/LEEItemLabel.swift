//
//  LEEItemLabel.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEEItemLabel: UILabel {
    
    public var item: LEEItem!
    
    public var textChangedBlock: () -> ()!
    
    class func label() -> LEEItemLabel {
        return LEEItemLabel(frame: .zero)
    }
    
    override init(frame: CGRect) {
        textChangedBlock = {
            () -> () in
            return
        }
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var text: String? {
        didSet{
            super.text = text!
            self.textChangedBlock()
        }
    }
    
    override var attributedText: NSAttributedString? {
        didSet{
            super.attributedText = attributedText!
            self.textChangedBlock()
        }
    }
    
    override var font: UIFont! {
        didSet{
            super.font = font
            self.textChangedBlock()
        }
    }
    
    override var numberOfLines: Int {
        didSet{
            super.numberOfLines = numberOfLines
            self.textChangedBlock()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
