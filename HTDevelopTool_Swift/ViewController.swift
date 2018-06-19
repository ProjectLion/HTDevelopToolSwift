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
    
    var scrol: HTScrollTitleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .green
        
        let 🐶 = "🐶"
        let 😂 = 13
        
        let l = UILabel(x: 0, y: 60, width: 100, height: 100)
        l
        .ht_set(text: 🐶, font: ht_fontW(CGFloat(😂)), textColor: ht_color(r: 0, g: 0, b: 0, alpha: 1))
        .ht_set(lines: 0, textAlignment: .center)
        .ht_set(isFit: true)
        .ht_add(borderWith: 1, borderColor: .red, cornerRadius: 5)
        .ht_end()
        view.addSubview(l)
        
        let btn = UIButton(x: 0, y: 100, width: 80, height: 50, style: .custom)
//        btn.ht_set(backGroundColor: .red, state: .normal)
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        btn.ht_set(title: "测试", font: ht_fontW(10), color: .red, state: .normal)
        btn.setImage(UIImage(named: "icon_discover_on"), for: .normal)
        btn.ht_set(imgPointStyle: .top, spaceing: 100)
        view.addSubview(btn)
        
        var config = HTScrollTitleConfig()
        config.titleColor = .red
        config.selectTitleColor = .green
        config.indicatorColor = .blue
        config.borderColor = .black
        config.currentIndex = 4
        config.bottomLineColor = .darkGray
        scrol = HTScrollTitleView(frame: CGRect(x: 50, y: 200, width: SCREEN_W - 100, height: 50), titleArr: ["互动", "表演", "贴纸", "问我", "手", "铁血书生郭沫若", "从善如流马歇尔"], delegate: self, scrollTitleConfig: config)
        view.addSubview(scrol)
        
        let loading = MGLoadView(frame: CGRect(x: 50, y: 400, width: 150, height: 150))
        view.addSubview(loading)
    }
    
    @objc func test() {
        ht_print(message: "string")
        HTHUD.showProgress(animated: true)
        let mod = Model.Model_Struct.Model_Struct_1.Model_Struct_2.init(cc: 5)
    }
    
}

