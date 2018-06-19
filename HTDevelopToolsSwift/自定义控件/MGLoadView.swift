//
//  MGLoadView.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/6/14.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class MGLoadView: UIView {
    
    /// 外面的layer
    var animatedLayer1 = CAShapeLayer()
    /// 里面的layer
    var animatedLayer2 = CAShapeLayer()
    
    /// 必须宽高相等
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>))
        backgroundColor = ht_color(r: 10, g: 89, b: 226, alpha: 1)
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        let path = UIBezierPath()
        
        let lineW = self.frame.size.width / 3
        let startPoint = CGPoint(x: self.frame.size.width / 2 - lineW / 2, y: 20)
        
        let endPoint = CGPoint(x: startPoint.x + lineW, y: 20)
        
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: CGPoint(x: self.frame.size.width / 2, y: startPoint.y - 10))
        path.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y + lineW / 1.5))
        path.close()
        animatedLayer1.fillColor = UIColor.white.cgColor
        animatedLayer1.path = path.cgPath
        
        let p = UIBezierPath()
        p.move(to: CGPoint(x: self.ht_width / 2, y: self.ht_height / 2))
        p.addArc(withCenter: CGPoint(x: 50, y: 50), radius: (ht_width - 40) / 2, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
//        p.close()
        
//        let animated1 = CAKeyframeAnimation(keyPath: "position")
//        animated1.duration = 2
//        animated1.repeatCount = MAXFLOAT
//        animated1.path = p.cgPath
//        animated1.isRemovedOnCompletion = false
        
        let replicatorLayer1 = CAReplicatorLayer()
        replicatorLayer1.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        replicatorLayer1.addSublayer(animatedLayer1)
        replicatorLayer1.instanceCount = 6
        replicatorLayer1.instanceDelay = 0.2
        replicatorLayer1.instanceTransform = CATransform3DMakeRotation(CGFloat(Float.pi * 2 / 6), 0, 0, 1.0)
        
        layer.addSublayer(replicatorLayer1)
        
//        animatedLayer1.add(transformAnim, forKey: nil)
        
        let path1 = UIBezierPath()
        let w: CGFloat = self.frame.size.width / 4 - 5
        let startPoint1 = CGPoint(x: self.frame.size.width / 2, y: startPoint.y + lineW / 1.5)
        
        path1.move(to: startPoint1)
        path1.addLine(to: CGPoint(x: startPoint1.x + w / 2, y: startPoint1.y + 10))
        path1.addLine(to: CGPoint(x: startPoint1.x, y: startPoint1.y + 19))
        path1.addLine(to: CGPoint(x: startPoint1.x - w / 2, y: startPoint1.y + 10))
        path1.close()
        animatedLayer2.fillColor = UIColor.white.cgColor
        animatedLayer2.path = path1.cgPath
        
        let replicatorLayer2 = CAReplicatorLayer()
        replicatorLayer2.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        replicatorLayer2.addSublayer(animatedLayer2)
        replicatorLayer2.instanceCount = 3
        replicatorLayer2.instanceDelay = 1
        replicatorLayer2.instanceTransform = CATransform3DMakeRotation(CGFloat(Float.pi * 2 / 3), 0, 0, 1.0)
        
        layer.addSublayer(replicatorLayer2)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
