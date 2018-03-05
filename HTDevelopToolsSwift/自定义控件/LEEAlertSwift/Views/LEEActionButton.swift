//
//  LEEActionButton.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/3/1.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEEActionButton: UIButton {
    
    public var action: LEEAction?
    
    public var heightChangeBlock: () -> ()?
    
    class func button() -> LEEActionButton {
        return LEEActionButton(type: .custom)
    }
    
    
    /// 便利构造器
    private convenience init(type: UIButtonType) {
        self.init(type: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var borderColor: UIColor?
    private var borderWidth: CGFloat?
    private var topLayer: CALayer?
    private var bottomLayer: CALayer?
    private var leftLayer: CALayer?
    private var rightLayer: CALayer?
    
    private var actionHeight: CGFloat {
        return self.frame.size.height
    }
    
    private func set(action: LEEAction) {
        
        self.action = action
        
        self.clipsToBounds = true
        
        guard let title = action.title else {
            return
        }
        self.setTitle(title, for: .normal)
        
        guard let highlight = action.highlight else {
            return
        }
        self.setTitle(highlight, for: .highlighted)
        
        guard let attributedTitle = action.attributedTitle else {
            return
        }
        self.setAttributedTitle(attributedTitle, for: .normal)
        
        guard let attributedHighlight = action.attributedHighlight else {
            return
        }
        self.setAttributedTitle(attributedHighlight, for: .highlighted)
        
        guard let font = action.font else {
            return
        }
        self.titleLabel?.font = font
        
        guard let titleColor = action.titleColor else {
            return
        }
        self.setTitleColor(titleColor, for: .normal)
        
        guard let highlightColor = action.highlightColor else {
            return
        }
        self.setTitleColor(highlightColor, for: .highlighted)
        
        guard let backgroundColor = action.backgroundColor else {
            return
        }
        self.set(backGroundColor: backgroundColor, state: .normal)
        
        guard let backgroundHighlightColor = action.backgroundHighlightColor else {
            return
        }
        self.set(backGroundColor: backgroundHighlightColor, state: .highlighted)
        
        guard let borderColor = action.borderColor else {
            return
        }
        self.borderColor = borderColor
        
        guard let borderWidth = action.borderWidth else {
            return
        }
        self.borderWidth = borderWidth
        
        guard let image = action.image else {
            return
        }
        self.setImage(image, for: .normal)
        
        guard let hightImage = action.highlightImage else {
            return
        }
        self.setImage(hightImage, for: .highlighted)
        
        guard let height = action.height else {
            return
        }
        self.set(actionHeight: height)
        
        guard let cornerRadius = action.cornerRadius else {
            return
        }
        self.layer.cornerRadius = cornerRadius
        
        self.imageEdgeInsets = action.imageInsets!
        
        self.titleEdgeInsets = action.titleInsets!
        
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        
        switch action.borderPosition {
        case .Top:
            self.addTopLayer()
        case .Bottom:
            self.addBottomLayer()
        case .Left:
            self.addLeftLayer()
        case .Right:
            self.addRightLayer()
        }
        action.updateBlock = {
            [weak self]
            (act: LEEAction) -> () in
            self?.action = act
        }
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.topLayer != nil {
            self.topLayer?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.borderWidth!)
        }
        
        if self.bottomLayer != nil {
            self.bottomLayer?.frame = CGRect(x: 0, y: self.frame.size.height - self.borderWidth!, width: self.frame.size.width, height: self.borderWidth!)
        }
        
        if self.leftLayer != nil {
            self.leftLayer?.frame = CGRect(x: 0, y: 0, width: self.borderWidth!, height: self.frame.size.height)
        }
        
        if self.rightLayer != nil {
            self.rightLayer?.frame = CGRect(x: self.frame.size.width - self.borderWidth!, y: 0, width: self.borderWidth!, height: self.frame.size.height)
        }
    }
    
    private func set(actionHeight: CGFloat) {
        
        let isChange: Bool = self.actionHeight == actionHeight ? false : true
        
        var buttonFrame = self.frame
        
        buttonFrame.size.height = actionHeight
        
        self.frame = buttonFrame
        
        if isChange {
            self.heightChangeBlock()
        }
        
    }
    
    private func addTopLayer() {
        self.layer.addSublayer(self.topLayer!)
    }
    
    private func addBottomLayer() {
        self.layer.addSublayer(self.bottomLayer!)
    }
    
    private func addLeftLayer() {
        self.layer.addSublayer(self.leftLayer!)
    }
    
    private func addRightLayer() {
        self.layer.addSublayer(self.rightLayer!)
    }
    
    private func removeTopBorder() {
        if topLayer != nil {
            topLayer?.removeFromSuperlayer()
            topLayer = nil
        }
    }
    
    private func removeBottomBorder() {
        if bottomLayer != nil {
            bottomLayer?.removeFromSuperlayer()
            bottomLayer = nil
        }
    }
    
    private func removeLeftBorder() {
        if leftLayer != nil {
            leftLayer?.removeFromSuperlayer()
            leftLayer = nil
        }
    }
    
    private func removeRightBorder() {
        if rightLayer != nil {
            rightLayer?.removeFromSuperlayer()
            rightLayer = nil
        }
    }
    
    private func creatLayer() -> CALayer {
        
        let layer = CALayer()
        layer.backgroundColor = self.borderColor?.cgColor
        
        return layer
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension LEEActionButton{
    public func set(backGroundColor: UIColor, state: UIControlState) {
        
        let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backGroundColor.cgColor)
        context?.addRect(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setImage(img, for: state)
    }
}
