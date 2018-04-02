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
    
    
    
    let btnOne = UIButton(type: .custom)
    let lableOne = UILabel(frame: CGRect(x: 14, y: 100, width: UIScreen.main.bounds.width - 28, height: 40))
    let testLableOne = UILabel(frame: CGRect(x: 14, y: 140, width: UIScreen.main.bounds.width - 28, height: 40))
    var testStr = "0"
    var testStr1 = "0"
    
    let btnTwo = UIButton(type: .custom)
    let lableTwo = UILabel(frame: CGRect(x: 14, y: 440, width: UIScreen.main.bounds.width - 28, height: 40))
    let testLableTwo = UILabel(frame: CGRect(x: 14, y: 480, width: UIScreen.main.bounds.width - 28, height: 40))
    var testStrTwo = "1"
    var testStrTwo1 = "Z"
    let testDict = ["1":"Z", "2":"Y", "3":"X", "4":"W", "5":"V", "6":"U", "7":"T", "8":"S", "9":"R", "10":"Q", "11":"P", "12":"O", "13":"N", "14":"M", "15":"L", "16":"K", "17":"J", "18":"I", "19":"H", "20":"G", "21":"F", "22":"E", "23":"D", "24":"C", "25":"B", "26":"A"]
    
    let customView = CustomView(frame: CGRect.zero)
    
    let testLableThree = UILabel(frame: CGRect(x: 14, y: 830, width: UIScreen.main.bounds.width - 28, height: 40))
    
    override init(title: String) {
        super.init(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleColor = UIColor.red
        self.mainBgViewColor = UIColor.white
        self.isHaveTabBar = true
        
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
        scroll.backgroundColor = .white
        scroll.contentSize = CGSize(width: 0, height: UIScreen.main.bounds.height + 300)
        scroll.delegate = self
        self.BGView.addSubview(scroll)
        
        let testOneLabel = UILabel(frame: CGRect(x: 14, y: 20, width: UIScreen.main.bounds.width - 28, height: 80))
        testOneLabel.text = "第一题、 给定两个由0-9数字组成的最长可达30个字符的字符串，请计算他们对应的整数的和。"
        testOneLabel.font = UIFont.systemFont(ofSize: 14)
        testOneLabel.numberOfLines = 0
        testOneLabel.textColor = .red
        scroll.addSubview(testOneLabel)
        
        lableOne.text = testStr + "," + testStr1
        lableOne.font = UIFont.systemFont(ofSize: 14)
        lableOne.textColor = .black
        lableOne.textAlignment = .center
        scroll.addSubview(lableOne)
        
        testLableOne.text = "结果为：0"
        testLableOne.font = UIFont.systemFont(ofSize: 14)
        testLableOne.textColor = .orange
        testLableOne.textAlignment = .center
        scroll.addSubview(testLableOne)
        
        btnOne.frame = CGRect.zero
        btnOne.bounds = CGRect(x: 0, y: 0, width: 200, height: 50)
        btnOne.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 200)
        btnOne.setTitle("开始测试", for: .normal)
        btnOne.setTitleColor(UIColor.red, for: .normal)
        btnOne.addTarget(self, action: #selector(clickBtn1), for: .touchUpInside)
        scroll.insertSubview(btnOne, at: 0)
        
        
        let testTwoLabel = UILabel(frame: CGRect(x: 14, y: 240, width: UIScreen.main.bounds.width - 28, height: 200))
        testTwoLabel.text = "第二题、 给定一个数字，返回其对应的字符串，数字和字符串的对应关系如下: \n 1 -> Z \n 2 -> Y \n 3 -> X \n ... \n 25 -> B \n 26 -> A \n 27 -> ZZ \n 28 -> ZY \n ..."
        testTwoLabel.font = UIFont.systemFont(ofSize: 14)
        testTwoLabel.numberOfLines = 0
        testTwoLabel.textColor = .red
        scroll.addSubview(testTwoLabel)
        
        lableTwo.text = testStrTwo
        lableTwo.font = UIFont.systemFont(ofSize: 14)
        lableTwo.textColor = .black
        lableTwo.textAlignment = .center
        scroll.addSubview(lableTwo)
        
        testLableTwo.text = testStrTwo1
        testLableTwo.font = UIFont.systemFont(ofSize: 14)
        testLableTwo.textColor = .orange
        testLableTwo.numberOfLines = 0
        testLableTwo.textAlignment = .center
        scroll.addSubview(testLableTwo)
        
        btnTwo.frame = CGRect.zero
        btnTwo.bounds = CGRect(x: 0, y: 0, width: 200, height: 50)
        btnTwo.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 540)
        btnTwo.setTitle("开始测试", for: .normal)
        btnTwo.setTitleColor(UIColor.red, for: .normal)
        btnTwo.addTarget(self, action: #selector(clickBtn2), for: .touchUpInside)
        scroll.insertSubview(btnTwo, at: 0)
        
        let testThreeLabel = UILabel(frame: CGRect(x: 14, y: btnTwo.ht_bottom + 50, width: UIScreen.main.bounds.width - 28, height: 200))
        testThreeLabel.text = "第三题、 计算网约车司机的服务分，其计算的规则如下：\n 1、取最近的不多于50单(多于50单则取最近的50单) \n 2、对于每一单，乘客好评权重是1，差评是-1，投诉是-3， \n 服务分 = 总权重 * 100 / 总单数 \n 设计相应的数据结构和接口，其中接口定义要求如下: \n 1、输入：最近一单的评分情况：好评/差评/投诉 \n 2、输出：服务分"
        testThreeLabel.font = UIFont.systemFont(ofSize: 14)
        testThreeLabel.numberOfLines = 0
        testThreeLabel.textColor = .red
        scroll.addSubview(testThreeLabel)
        
        testLableThree.text = "0.0"
        testLableThree.font = UIFont.systemFont(ofSize: 14)
        testLableThree.textColor = .orange
        testLableThree.textAlignment = .center
        scroll.addSubview(testLableThree)
        
        let btnThree = UIButton(type: .custom)
        btnThree.frame = CGRect.zero
        btnThree.bounds = CGRect(x: 0, y: 0, width: 200, height: 50)
        btnThree.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: testThreeLabel.ht_bottom + 100)
        btnThree.setTitle("开始测试", for: .normal)
        btnThree.setTitleColor(UIColor.red, for: .normal)
        btnThree.addTarget(self, action: #selector(clickBtn3), for: .touchUpInside)
        scroll.insertSubview(btnThree, at: 0)
        
        
        self.BGView.addSubview(customView)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clickRightItem() {
        print("重写父类的右边item点击响应方法")
    }
    
    /// 第一题按钮点击方法
    @objc func clickBtn1(){
//        LEEAlert.alert().config?.LeeAddAction({ (action) in
//            action.title = "测试"
//            action.borderColor = .red
//        })?
//        .LeeShow()
        testStr = "\(arc4random_uniform(999999999))"
        testStr1 = "\(arc4random_uniform(999999999))"
        lableOne.text = testStr + "," + testStr1
        let result: uint = uint(testStr)! + uint(testStr1)!
        testLableOne.text = "结果为：\(result)"
        
    }
    /// 第二题按钮点击方法
    @objc func clickBtn2(){
        var resultStr = ""
        let random = arc4random_uniform(780)
        
        if random < 26 || random == 26 && random > 0 {
            testStrTwo = "\(random)"
            resultStr = testDict[testStrTwo]!
        }else{
            if random % 26 == 0 {
                for i in 0...(random / 26) - 1 {
                    
                    if i < random / 26 - 1 {
                        resultStr.append("Z")
                    }else{
                        resultStr.append("A")
                    }
                }
            }else{
                for i in 0..<(random / 26) {
                    resultStr.append("Z")
                    if i == random / 26 - 1 {
                        resultStr.append(testDict["\(random % 26)"]!)
                    }
                }
            }
            
        }
        lableTwo.text = "\(random)"
        testLableTwo.text = resultStr
    }
    /// 第三题按钮点击方法
    @objc func clickBtn3(){
        customView.block = { [weak self]
            (_ start: Float) in
            
            self?.testLableThree.text = "\(start)"
            
            return nil
        }
        customView.show()
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

extension TestViewController: HTDatePickerDelegate, UIScrollViewDelegate{
    
    func clickEnsure(selectDate: String) {
        print(selectDate)
//        date.hideDatePicker()
    }
}
