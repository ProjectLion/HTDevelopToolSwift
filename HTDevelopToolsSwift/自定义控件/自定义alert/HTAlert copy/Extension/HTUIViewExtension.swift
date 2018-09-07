//
//  HTUIViewExtension.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/15.
//  Copyright © 2017年 HT. All rights reserved.
//

import Foundation
import UIKit

/**
 *   properties
 */
extension UIView {
    /// 边框线位置
    public struct BorderPosition : OptionSet {
        
        public let rawValue: Int
        
        public static let left = BorderPosition(rawValue: 1 << 0)
        
        public static let top = BorderPosition(rawValue: 1 << 1)
        
        public static let right = BorderPosition(rawValue: 1 << 2)
        
        public static let bottom = BorderPosition(rawValue: 1 << 3)
        
        public static let all: BorderPosition = [.top, .right, .left, .bottom]
        
        
        
        public init(rawValue: Int) {
            
            self.rawValue = rawValue;
            
        }
    }
}

/**
 *   Method
 */
extension UIView {
    
    /// 创建一个view
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - width: width
    ///   - height: height
    ///   - backGroundColor: 背景色
    convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, backGroundColor: UIColor = .white){
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.backgroundColor = backGroundColor
    }
    
    /// 收尾
    open func ht_end() {
        
    }
    
    /// 添加边框、颜色及切圆角 (默认为灰色1.5宽的边框,圆角半径为5)
    ///
    /// - Parameters:
    ///   - borderWith: 边框宽
    ///   - borderColor: 边框颜色
    ///   - cornerRadius: 圆角半径
    open func ht_add(borderWith: CGFloat = 1.5, borderColor: UIColor = .gray, cornerRadius: CGFloat = 5) -> UIView {
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        if cornerRadius > 0 {
            self.clipsToBounds = true
        }
        return self
    }
    
    /// 对当前view截图
    ///
    /// - Returns: 返回UIImage or nil
    open func shot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        if self.responds(to: #selector(drawHierarchy(in:afterScreenUpdates:))) {
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        } else {
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
        }
        let shotImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return shotImg
    }
    
    ///画虚线边框
    
    func drawDashLine(strokeColor: UIColor, lineWidth: CGFloat = 1, lineLength: Int = 10, lineSpacing: Int = 5, corners: BorderPosition) {
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.bounds = self.bounds
        
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        
        shapeLayer.fillColor = UIColor.blue.cgColor
        
        shapeLayer.strokeColor = strokeColor.cgColor
        
        
        
        shapeLayer.lineWidth = lineWidth
        
        shapeLayer.lineJoin = CAShapeLayerLineJoin.miter
        
        
        
        //每一段虚线长度 和 每两段虚线之间的间隔
        
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        
        
        
        let path = CGMutablePath()
        
        if corners.contains(.left) {
            
            path.move(to: CGPoint(x: 0, y: self.layer.bounds.height))
            
            path.addLine(to: CGPoint(x: 0, y: 0))
            
        }
        
        if corners.contains(.top){
            
            path.move(to: CGPoint(x: 0, y: 0))
            
            path.addLine(to: CGPoint(x: self.layer.bounds.width, y: 0))
            
        }
        
        if corners.contains(.right){
            
            path.move(to: CGPoint(x: self.layer.bounds.width, y: 0))
            
            path.addLine(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
            
        }
        
        if corners.contains(.bottom){
            
            path.move(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
            
            path.addLine(to: CGPoint(x: 0, y: self.layer.bounds.height))
            
        }
        
        shapeLayer.path = path
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    ///画实线边框
    
    func drawLine(strokeColor: UIColor, lineWidth: CGFloat = 1, corners: BorderPosition) {
        
        if corners == BorderPosition.all {
            
            self.layer.borderWidth = lineWidth
            
            self.layer.borderColor = strokeColor.cgColor
            
        }else{
            
            let shapeLayer = CAShapeLayer()
            
            shapeLayer.bounds = self.bounds
            
            shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            
            shapeLayer.fillColor = UIColor.blue.cgColor
            
            shapeLayer.strokeColor = strokeColor.cgColor
            
            shapeLayer.lineWidth = lineWidth
//            shapeLayer.lineJoin
            
            let path = CGMutablePath()
            
            if corners.contains(.left) {
                path.move(to: CGPoint(x: 0, y: self.layer.bounds.height))
                path.addLine(to: CGPoint(x: 0, y: 0))
            }
            if corners.contains(.top){
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: self.layer.bounds.width, y: 0))
            }
            if corners.contains(.right){
                path.move(to: CGPoint(x: self.layer.bounds.width, y: 0))
                path.addLine(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
            }
            if corners.contains(.bottom){
                path.move(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
                path.addLine(to: CGPoint(x: 0, y: self.layer.bounds.height))
            }
            shapeLayer.path = path
            self.layer.addSublayer(shapeLayer)
        }
    }
    
}





