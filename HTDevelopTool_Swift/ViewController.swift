//
//  ViewController.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/14.
//  Copyright © 2017年 HT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HTScrollTitleDelegate {
//    let ct = CTCarrier()
    func titleScroll(scroll: HTScrollTitleView, selectIndex: Int) {
        print("HT------>DEBUG: index\(selectIndex)")
    }
    
    var scrol: HTScrollTitleView!
    
    let proportion: CGFloat = 333 / 750
    
    /// 顶部背景图
    lazy var headerImage: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "PersonCenter_HeaderImg"))
        img.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_W * proportion)
        return img
    }()
    
    /// 个人信息
    lazy var userInfoView: UIView = {
        let v = UIView(x: 0, y: headerImage.ht_bottom, width: SCREEN_W, height: 150, backGroundColor: .white)
        return v
    }()
    
    /// 头像
    lazy var userIcon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "icon_discover_on"))
        img.ht_width = ht_W(83)
        img.ht_height = ht_W(83)
        img.ht_centerX = SCREEN_W / 2
        img.ht_centerY = SCREEN_W * proportion
        img.backgroundColor = .red
        img.layer.cornerRadius = ht_W(83) / 2
        img.layer.masksToBounds = true
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .green
        view.addSubview(headerImage)
        view.addSubview(userInfoView)
        view.addSubview(userIcon)
        HTAlamofireManager.post(url: "s", parameters: nil, header: nil, success: { (data) in
            
        }) { (error) in
            
        }
    }
    
    @objc func test() {
//        ht_print(message: "string")
//        HTHUD.showProgress(animated: true)
        let mod = Model()
        mod.setValue("3", forKey: "desc")
//        let mod = Model.Model_Struct.Model_Struct_1.Model_Struct_2.init(cc: 5)
//
//        ht_print(message: transform(timeString: "1天"))
        
    }
    
}
