//
//  HTCustomNavController.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/14.
//  Copyright © 2017年 HT. All rights reserved.
//

import UIKit
/// 自定义导航条的风格
enum HTCustomNavStyle: UInt {
    case Title = 0                  //只有title
    case BackTile                   //包含返回按钮 & title
    case BackTitleRightTitle        //包含返回按钮 & title & 右边文字item
    case BackTitleRightImage        //包含返回按钮 & title & 右边图片item
}

/// 自定义导航条控制器
class HTCustomNavController: UIViewController {
    
    // MARK: 公开给外部的自定义接口
    /// 该控制器的界面是否有tabBar(默认为没有)
    open var isHaveTabBar: Bool = false
    
    /// 导航条颜色(默认为白色)
    open var navColor: UIColor = UIColor.white{
        didSet{
            topView.backgroundColor = navColor
        }
    }
    
    /// 主视图的背景色(默认为白色)
    open var mainBgViewColor: UIColor = UIColor.white{
        didSet{
            BGView.backgroundColor = mainBgViewColor
        }
    }
    
    /// 统一设置所有导航条上文字的字体色(默认为透明)
    open var allTitleColor: UIColor = UIColor.clear{
        didSet{
            titleLabel.textColor = allTitleColor
            rightBtn.setTitleColor(allTitleColor, for: .normal)
        }
    }
    
    /// 导航条title的字体色(默认为红色)
    open var titleColor: UIColor = UIColor.red{
        didSet{
            titleLabel.textColor = titleColor
        }
    }
    
    open var rightTitleColor: UIColor = UIColor.gray{
        didSet{
            rightBtn.setTitleColor(rightTitleColor, for: .normal)
        }
    }
    
    /// 导航条title(默认为title)
    open var navTitle: String = "title"{
        didSet{
            titleLabel.text = navTitle
        }
    }
    
    /// 返回按钮本地图片名
    open var backImageString: String = ""{
        didSet{
            backBtn.setImage(UIImage.init(named: backImageString), for: .normal)
        }
    }
    
    /// 右边item的title(文字形式)
    open var rightTitle: String = "rightTitle"{
        didSet{
            rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    
    /// 右边item的本地图片名(图片形式)
    open var rightImgString: String = ""{
        didSet{
            rightBtn.setImage(UIImage.init(named: rightImgString), for: .normal)
        }
    }
    /**************************************/
    
    // MARK: 私有的常量
    fileprivate let navHeight: CGFloat = isIphoneX ? 88.0 : 64.0
    fileprivate let viewY: CGFloat = isIphoneX ? 44.0 : 20.0
    
    // MARK: 私有的视图控件
    private lazy var BGView = UIView()                           /// 空白出背景图层
    private lazy var topView = UIView()                          /// 导航条背景图层
    private lazy var backBtn = UIButton(type: .custom)           /// 返回按钮
    private lazy var titleLabel = UILabel()                      /// titleLabel
    private lazy var rightBtn = UIButton(type: .custom)          /// 右边的item
    
//    open var style: HTCustomNavStyle = .Title;
    
    /// 创建自定义导航条控制器(其他属性的值需自己单独设置)
    ///
    /// - Parameter style: 导航条风格
//    init(style: HTCustomNavStyle) {
//        super.init(nibName: nil, bundle: nil)
//    }
    
    /// 创建自定义导航条控制器
    ///
    /// - Parameter title: title
    init(title: String) {
        navTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    /// 创建自定义导航条控制器
    ///
    /// - Parameters:
    ///   - backImgString: 返回按钮图片string
    ///   - title: title
    init(imageString backImgString: String, title: String) {
        backImageString = backImgString
        navTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    /// 创建自定义导航条控制器
    ///
    /// - Parameters:
    ///   - backImgString: 返回按钮图片
    ///   - title: title
    ///   - rightTitle: 右边item(文字形式)
    init(imageString backImgString: String, title: String, rightTitle: String) {
        backImageString = backImgString
        navTitle = title
        self.rightTitle = rightTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    /// 创建自定义导航条控制器
    ///
    /// - Parameters:
    ///   - backImgString: 返回按钮图片
    ///   - title: title
    ///   - rightImgString: 右边item(图片形式)
    init(imageString backImgString: String, title: String, rightImgString: String) {
        backImageString = backImgString
        navTitle = title
        self.rightImgString = rightImgString
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 布局视图
    fileprivate func creatView(){
        view.backgroundColor = UIColor.white
        self.creatNavView()
        self.creatMainView()
    }
    /// 布局导航条
    fileprivate func creatNavView(){
        
        topView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: navHeight))
        topView.backgroundColor = UIColor.white
        view.addSubview(topView)
        
        backBtn = UIButton(type: .custom)
        backBtn.setTitleColor(UIColor.red, for: .normal)
        backBtn.setTitle(navTitle, for: .normal)
        backBtn.frame = CGRect(x: 20, y: viewY, width: 44, height: 44)
        backBtn.addTarget(self, action: #selector(clickBackBtn), for: .touchUpInside)
        topView.addSubview(backBtn)
        
        titleLabel = UILabel(frame: CGRect(x: ht_W(125), y: viewY, width: ht_W(130), height: 44))
        titleLabel.text = navTitle
        titleLabel.textAlignment = .center
        titleLabel.textColor = titleColor
        titleLabel.font = ht_fontW(17)
        topView.addSubview(titleLabel)
        
        rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: ht_W(320), y: viewY, width: 44, height: 44)
        rightBtn.adjustsImageWhenHighlighted = false
        rightBtn.setTitleColor(rightTitleColor, for: .normal)
        rightBtn.setImage(UIImage.init(named: rightImgString), for: .normal)
        rightBtn.addTarget(self, action: #selector(clickRightItem), for: .touchUpInside)
        topView.addSubview(rightBtn)
        
    }
    /// 布局主视图
    fileprivate func creatMainView(){
        BGView.frame = CGRect(x: 0, y: navHeight, width: SCREEN_W, height: SCREEN_H - navHeight)
        BGView.backgroundColor = mainBgViewColor
        /// 如果有tabBar,减去tabBar的高度
        if isHaveTabBar {
            if isIphoneX {
                BGView.ht_height = SCREEN_H - navHeight - 83
            }else{
                BGView.ht_height = SCREEN_H - navHeight - 49
            }
        }
        view.addSubview(BGView)
    }
    
    /// 右边item的点击响应方法,具体实现交给子类去重写
    @objc func clickRightItem(){
        
    }
    
    /// 返回按钮点击响应方法 统一设置方法体 子类无法重写
    @objc final func clickBackBtn() {
        if self.navigationController?.viewControllers == nil{
            self.dismiss(animated: true, completion: nil)
        }else if self.navigationController?.viewControllers.last != self{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.creatView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

/// 自定义接口
extension HTCustomNavController{
    
    
    
    func setTitleColor(color: UIColor){
        backBtn.setTitleColor(color, for: .normal)
    }
    
}






