//
//  TestViewController.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 HT. All rights reserved.
//

import UIKit

class TestViewController: HTCustomNavController {
    
    fileprivate var t = ""
    
    var test: String {
        get{
            return "测试测试"
        }
        set{
            
            t = newValue
            print(t)
        }
    }
    
    override init(title: String) {
        super.init(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleColor = UIColor.red
        self.mainBgViewColor = UIColor.green
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clickRightItem() {
        print("重写父类的右边item点击响应方法")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let date = HTDatePickerSwift(frame: CGRect.init(x: 0, y: SCREEN_H, width: SCREEN_W, height: 300), style: .YMDHMS)
        date.isCanSelectBefore = true
        date.delegate = self
        view.addSubview(date)
        date.showDatePicker()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TestViewController: HTDatePickerDelegate{
    
    func clickEnsure(selectDate: String) {
        print(selectDate)
//        date.hideDatePicker()
    }
}
