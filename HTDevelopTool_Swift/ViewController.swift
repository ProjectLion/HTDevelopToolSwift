//
//  ViewController.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/14.
//  Copyright © 2017年 HT. All rights reserved.
//

import UIKit

func 如果(这是条件: Bool) {
    if 这是条件 {
        
    } else {
        
    }
}

class ViewController: UIViewController, HTScrollTitleDelegate {
//    let ct = CTCarrier()
    func titleScroll(scroll: HTScrollTitleView, selectIndex: Int) {
        print("HT------>DEBUG: index\(selectIndex)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let 🐶 = "🐶"
        let 😂 = 13
        
        let l = UILabel(x: 0, y: 60, width: 100, height: 100)
        l
        .ht_set(text: 🐶, font: ht_fontW(CGFloat(😂)), textColor: ht_color(r: 0, g: 0, b: 0, alpha: 1))
        .ht_set(lines: 0, textAlignment: .center)
        .ht_add(borderWith: 1, borderColor: .red, cornerRadius: 5)
        .ht_set(isFit: true)
        .ht_end()
        view.addSubview(l)
        
        let btn = UIButton(x: 0, y: 100, width: 80, height: 50, style: .custom)
        btn.ht_set(backGroundColor: .red, state: .normal)
        view.addSubview(btn)
        
        let config = HTScrollTitleConfig()
        config.titleColor = .red
        config.selectTitleColor = .green
        config.indicatorColor = .blue
        config.borderColor = .black
        config.currentIndex = 4
//        config.animatedTimeValue = 0.6
        config.bottomLineColor = .darkGray
        let scrol = HTScrollTitleView(frame: CGRect(x: 50, y: 200, width: SCREEN_W - 100, height: 50), titleArr: ["互动", "表演", "贴纸", "问我", "手", "铁血书生郭沫若", "从善如流马歇尔"], delegate: self, scrollTitleConfig: config)
        view.addSubview(scrol)
    }
    
    
    
}

