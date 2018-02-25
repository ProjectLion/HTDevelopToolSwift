//
//  CustomView.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/2/25.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    var cellctStart = ""
    let textFild = UITextField(frame: CGRect(x: SCREEN_W / 2 - 50, y: 80, width: 100, height: 30))
    var dataSource:[Model] = []
    
    var start: Float = 0
    
    var block: (_ start: Float) -> Void?
    
    override init(frame: CGRect) {
        block = {
            (start: Float) in
            return nil
        }
        super.init(frame: CGRect(x: 0, y: -314, width: SCREEN_W, height: 250))
        self.loadView()
    }
    
    func loadView() {
        self.backgroundColor = .white
        
        textFild.delegate = self
        textFild.placeholder = "查询订单服务分"
        textFild.textAlignment = .center
        textFild.textColor = .black
        textFild.returnKeyType = .done
//        textFild.keyboardType = .phonePad
        self.addSubview(textFild)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: SCREEN_W / 2 - 30, y: 150, width: 60, height: 30)
        btn.setTitle("查询", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        self.addSubview(btn)
    }
    
    @objc func clickBtn() {
        self.countStart()
        self.hide()
    }
    /// 随机数据数组
    func initData(){
        for i in 0...arc4random_uniform(60) {
            let model = Model()
            model.orderID = "orderID\(i)"
            switch i {
            case 3:
                model.start = -3
            case 2,4,6,8:
                model.start = -1
            default:
                model.start = 1
            }
            dataSource.append(model)
        }
    }
    
    /// 计算服务分
    func countStart(){
        var data: [Model] = []
        if dataSource.count > 50 {
            data = Array(dataSource[dataSource.count - 50...dataSource.count - 1])
        }else{
            data = dataSource
        }
        for i in 0..<data.count {
            if i == data.count - 1 {
                data[i].start = Float(cellctStart)
            }
            start += data[i].start!
        }
        start = start * 100 / Float(dataSource.count)
        self.block(start)
    }
    
    func show(){
        if dataSource.count > 0 {
            dataSource.removeAll()
        }
        start = 0
        self.initData()
        UIView.animate(withDuration: 0.25, animations: {
            self.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: 250)
        }) { (finished) in
            if finished {
                self.textFild.becomeFirstResponder()
            }
        }
    }
    
    func hide(){
        textFild.resignFirstResponder()
        UIView.animate(withDuration: 0.25) {
            self.frame = CGRect(x: 0, y: -314, width: SCREEN_W, height: 250)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CustomView: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cellctStart = textField.text!
        self.countStart()
        self.hide()
        return true
    }
    
}
