//
//  ViewController.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/14.
//  Copyright © 2017年 HT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let v = UIView(frame: CGRect(x: ht_W(1), y: 200, width: 200, height: 50))
        v.backgroundColor = ht_colorWith(hexValue: 0xefefef)
        view.addSubview(v)
        var arr: Array = [1, 2, 3]
        arr.append(7)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let testVC = TestViewController(title: "vc")
//        testVC.navTitle = "返回"
//        testVC.test = "ddddd"
//        testVC.rightTitle = "rightTitle"
//        testVC.rightTitleColor = UIColor.red
//        testVC.mainBgViewColor = UIColor.blue
//        testVC.isHaveTabBar = true
//        print(testVC.isHaveTabBar)
        self.present(testVC, animated: true, completion: nil)
    }

}

