//
//  VoiceWaveView.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2019/4/22.
//  Copyright © 2019 HT. All rights reserved.
//

import UIKit

class VoiceWaveView: UIView {
	
    private var voiceBorder: UIView = {
        let voice = UIView()
        voice.backgroundColor = .clear
        voice.layer.borderWidth = 2
        voice.layer.borderColor = UIColor.white.cgColor
        voice.clipsToBounds = true
        return voice
    }()
    /// 音量动态大小layer
    private var voiceContent: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    /// 托盘layer
    private var trayLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(voice: CGFloat) {
        var voi = voice
        if voi > 110 {
            assert(true, "分贝超出")
            voi = 110
        }
        voiceContent.path = UIBezierPath(roundedRect: CGRect(x: 0, y: voiceBorder.frame.height - (voi / 110.0) * voiceBorder.frame.height, width: voiceBorder.frame.width, height: voiceBorder.frame.height), cornerRadius: 0).cgPath
    }
    
}

// MARK: ^^^^^^^^^^^^^^^ privateMethods ^^^^^^^^^^^^^^^
extension VoiceWaveView {
    /// 初始化
    private func setUp() {
        
        backgroundColor = .black
        alpha = 0.4
        cornerRadius = 2
        voiceBorder.center = CGPoint(x: frame.width / 2, y: frame.height / 2 - 10)
        voiceBorder.bounds = CGRect(x: 0, y: 0, width: frame.width / 5, height: 40)
        voiceBorder.layer.cornerRadius = frame.width / 10
        voiceBorder.clipsToBounds = true
        addSubview(voiceBorder)
        
        voiceContent.path = UIBezierPath(roundedRect: CGRect(x: 0, y: voiceBorder.frame.height - (50 / 110) * voiceBorder.frame.height, width: voiceBorder.frame.width, height: voiceBorder.frame.height), cornerRadius: 0).cgPath
        voiceBorder.layer.addSublayer(voiceContent)
        
        let path = UIBezierPath()
//        path.lineWidth = 3
        // 起点
        let startP = CGPoint(x: frame.width / 2 - frame.width / 10 - 5, y: frame.height / 2 - 3)
        path.move(to: startP)
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + 3))
        
        path.addArc(withCenter: CGPoint(x: frame.width / 2, y: frame.height / 2), radius: frame.width / 10 + 5, startAngle: .pi, endAngle: 0, clockwise: false)
        
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - 3))
        
        path.move(to: CGPoint(x: frame.width / 2, y: voiceBorder.frame.maxY + 5))
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + 10))
        
        path.move(to: CGPoint(x: frame.width / 2 - 10, y: path.currentPoint.y))
        path.addLine(to: CGPoint(x: path.currentPoint.x + 20, y: path.currentPoint.y))
        
        path.stroke()
        trayLayer.path = path.cgPath
        trayLayer.strokeColor = UIColor.white.cgColor
        trayLayer.lineWidth = 3
        trayLayer.lineCap = .round		// 线头形状
        layer.addSublayer(trayLayer)
        
    }
}
