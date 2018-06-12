//
//  HTScrollTitleView.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/6/5.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

struct HTScrollTitleConfig {
    
    init() {
    }
    
    /// 指示器滑动的样式
    public enum IndicatorFollowStyle {
        /// 跟随改变
        case follow
        /// 滑到一半时改变
        case half
        /// 滑动完成时改变
        case end
    }
    
    /// 指示器样式
    public enum IndicatorStyle {
        /// 下划线
        case bottomLine
        /// 遮盖
        case cover
        /// 固定
        case fix
    }
    
    //MARK: ^^^^^^^^^^^^^^^ titleScrollView的属性 ^^^^^^^^^^^^^^^
    /// 弹性效果 默认 true
    public var isNeedBounces = true
    /// 分割线 默认 true
    public var isShowBottomLine = true
    /// 分割线的颜色 默认白色
    public var bottomLineColor: UIColor = .white
    /// 默认选中哪一个 默认第0个
    public var currentIndex = 0
    
    //MARK: ^^^^^^^^^^^^^^^ 标题配置 ^^^^^^^^^^^^^^^
    /// 标题字体 默认14号字
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    /// 标题颜色 默认高亮灰色
    public var titleColor: UIColor = .lightGray
    /// 选中标题字体 默认16号字
    public var selectTitleFont: UIFont = UIFont.systemFont(ofSize: 20)
    /// 选中标题字体颜色 默认白色
    public var selectTitleColor = UIColor.white
    /// 是否需要渐变效果 默认false
    public var isGradientEffect = false
    /// 是否需要缩放效果 默认true
    public var isZoom = true
    /// 标题缩放比例 默认0.1 (0 ~ 0.3)
    public var titleZoomScale:CGFloat = 0.1
    /// 标题的间距 默认40
    public var titleSpacing: CGFloat = 40
    
    //MARK: ^^^^^^^^^^^^^^^ 指示器配置 ^^^^^^^^^^^^^^^
    /// 是否显示指示器 默认true
    public var isShowIndicator = true
    /// 指示器颜色 默认白色
    public var indicatorColor = UIColor.white
    /// 指示器的高度 默认2 (遮盖模式下默认跟k本身控件一样高)
    public var indicatorHeight: CGFloat = 2
    /// 指示器动画的时长 默认0.4 (0 ~ 1)
    public var animatedTimeValue = 0.4
    /// 指示器的样式 默认为下划线
    public var indicatorStyle: HTScrollTitleConfig.IndicatorStyle = .bottomLine
    /// 指示器的圆角大小 默认为0 (indicatorStyle为cover时生效)
    public var indicatorCorner: CGFloat = 0
    /// 遮盖样式下的边框宽度 默认1
    public var borderWidth: CGFloat = 1
    /// 遮盖样式下的边框颜色 默认白色
    public var borderColor = UIColor.white
    /// 指示器滚动样式 默认为follow
    public var indicatorFollowStyle: HTScrollTitleConfig.IndicatorFollowStyle = .follow
}


protocol HTScrollTitleDelegate {
    func titleScroll(scroll: HTScrollTitleView, selectIndex: Int)
}
/// 指示器多出来的宽
fileprivate let indicatorMoreW: CGFloat = 14

class HTScrollTitleView: UIView {
    
    /// 代理
    public var scrollDelegate: HTScrollTitleDelegate!
    
    /// 当前选中的index 默认选中第0个
    private var selectIndex = 0
    
    /// 记录所有按钮的宽度
    private var allButtonWidth: CGFloat = 0
    /// 记录整个控件的宽度
    private var allWidth: CGFloat = 0
    
    private var tempBtn: UIButton?
    
    private var titleArray: Array<String> = []
    private var config: HTScrollTitleConfig!
    
    /*****      懒加载控件      ******/
    private lazy var scroll: UIScrollView = {
        let scrol = UIScrollView(frame: CGRect(x: 0, y: 0, width: ht_width, height: ht_height))
        scrol.showsVerticalScrollIndicator = false
        scrol.showsHorizontalScrollIndicator = false
        scrol.alwaysBounceHorizontal = true
        scrol.backgroundColor = .clear
        scrol.bounces = config.isNeedBounces
        return scrol
    }()
    
    /// 指示器
    private lazy var indicator: UIView = {
        let v = UIView()
        switch config.indicatorStyle {
        case .cover:
            let H = height(str: btnArray[config.currentIndex].currentTitle!, font: config.titleFont)
            if config.indicatorHeight > ht_height {     // 超过本身控件大小
                v.ht_height = ht_height
            } else if config.indicatorHeight < H {      // 小于字体高度
                v.ht_height = H
            } else {        // 其他
                v.ht_height = config.indicatorHeight
            }
            v.layer.borderWidth = config.borderWidth
            v.layer.borderColor = config.borderColor.cgColor
            // 遮盖才有圆角
            if config.indicatorCorner > 0.5 * v.ht_height {
                v.layer.cornerRadius = 0.5 * v.ht_height
            } else {
                v.layer.cornerRadius = config.indicatorCorner
            }
            v.ht_centerY = btnArray[config.currentIndex].ht_centerY
        default:
            v.ht_height = config.indicatorHeight
            v.ht_y = ht_height - config.indicatorHeight
        }
        
        v.ht_width = width(str: btnArray[config.currentIndex].currentTitle!, font: config.titleFont) + indicatorMoreW
        v.ht_centerX = btnArray[config.currentIndex].ht_centerX
        v.backgroundColor = config.indicatorColor
        return v
    }()
    
    /// 分割线
    private lazy var bottomLine: UIView = {
        let v = UIView(x: 0, y: ht_height - 0.5, width: ht_width, height: 0.5, backGroundColor: config.bottomLineColor)
        return v
    }()
    
    private lazy var btnArray: Array<UIButton> = {
        let arr: Array<UIButton> = []
        return arr
    }()
    
    /**************************/
    
    
    
    convenience init(frame: CGRect, titleArr: Array<String>, delegate: HTScrollTitleDelegate, scrollTitleConfig: HTScrollTitleConfig) {
        self.init(frame: frame)
        config = scrollTitleConfig
        backgroundColor = .white
        scrollDelegate = delegate
        titleArray = titleArr
        if config.currentIndex >= titleArray.count {
            config.currentIndex = titleArray.count - 1
        } else if config.currentIndex < 0 {
            config.currentIndex = 0
        }
        creatUI()
        if tempBtn == nil {
            tempBtn = btnArray[config.currentIndex]
            btnArray[config.currentIndex].isSelected = true
            selectBtnToCenter(btn: tempBtn!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 标题按钮相应方法
    @objc private func buttonAction(btn: UIButton) {
        changeIndicatorPositionTo(btn: btn)
        // 改变按钮的选中状态
        changeBtnSelectStatus(btn: btn)
        if allWidth > ht_width {
            selectBtnToCenter(btn: btn)
        }
        scrollDelegate.titleScroll(scroll: self, selectIndex: btn.tag)
        selectIndex = btn.tag
    }
    
    /// 改变按钮的选中状态
    private func changeBtnSelectStatus(btn: UIButton) {
        tempBtn?.isSelected = false
        btn.isSelected = true
        tempBtn = btn
        
        if config.titleFont == UIFont.systemFont(ofSize: 14) {
            if config.isZoom {
                for item in btnArray {
                    let btn = item
                    btn.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                btn.transform = CGAffineTransform(scaleX: 1 + config.titleZoomScale, y: 1 + config.titleZoomScale)
            }
            // 渐变效果
            if config.isGradientEffect {
                for item in btnArray {
                    let btn = item
                    btn.titleLabel?.textColor = config.titleColor
                }
                btn.titleLabel?.textColor = config.selectTitleColor
            }
        } else {
            if config.isGradientEffect {
                for item in btnArray {
                    let btn = item
                    btn.titleLabel?.textColor = config.titleColor
                    btn.titleLabel?.font = config.titleFont
                }
                btn.titleLabel?.textColor = config.selectTitleColor
                btn.titleLabel?.font = config.selectTitleFont
            } else {
                for item in btnArray {
                    let btn = item
                    btn.titleLabel?.font = config.titleFont
                }
                btn.titleLabel?.font = config.selectTitleFont
            }
        }
    }
    
    //MARK: ^^^^^^^^^^^^^^^ 选中按钮居中 ^^^^^^^^^^^^^^^
    /// 选中按钮居中
    private func selectBtnToCenter(btn: UIButton) {
        var offsetX = btn.ht_centerX - ht_width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        let maxOffsetX = scroll.contentSize.width - ht_width
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scroll.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    //MARK: ^^^^^^^^^^^^^^^ 改变指示器的位置及其宽度 ^^^^^^^^^^^^^^^
    /// 改变指示器的位置及其宽度
    private func changeIndicatorPositionTo(btn: UIButton) {
        
        UIView.animate(withDuration: config.animatedTimeValue) {
            self.indicator.ht_width = self.width(str: self.btnArray[btn.tag].currentTitle!, font: self.config.titleFont) + indicatorMoreW
            self.indicator.ht_centerX = self.btnArray[btn.tag].ht_centerX
        }
        
    }
    
    //MARK: ^^^^^^^^^^^^^^^ 计算字符串的宽 ^^^^^^^^^^^^^^^
    /// 计算字符串的宽
    private func width(str: String, font: UIFont) -> CGFloat {
        return (str as NSString).boundingRect(with: CGSize(width: 0, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size.width
    }
    /// 计算字符串的高
    private func height(str: String, font: UIFont) -> CGFloat {
        return (str as NSString).boundingRect(with: CGSize(width: 0, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size.height
    }
    
    //MARK: ^^^^^^^^^^^^^^^ 颜色计算 ^^^^^^^^^^^^^^^
    /// 开始颜色
    private func startColor(color: UIColor) {
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

//MARK: ^^^^^^^^^^^^^^^ setUpUI ^^^^^^^^^^^^^^^
extension HTScrollTitleView {
    /// 视图布局
    private func creatUI() {
        addSubview(scroll)
        addBtnTiltes()
        if config.isShowBottomLine {
            addSubview(bottomLine)
        }
        if config.isShowIndicator {
            scroll.insertSubview(indicator, at: 0)
        }
    }
    
    /// 添加按钮
    private func addBtnTiltes() {
        for (idx, _) in titleArray.enumerated() {
            let btnW = width(str: titleArray[idx], font: UIFont.systemFont(ofSize: 14))
            allButtonWidth += btnW
        }
        allWidth = config.titleSpacing * CGFloat(titleArray.count) + allButtonWidth
        
        var btnW: CGFloat = 0
        var btnH: CGFloat = 0
        var btnX: CGFloat = 0 / self.bounds.size.width / CGFloat(titleArray.count)
        
        if config.indicatorStyle == .bottomLine {
            btnH = ht_height - config.indicatorHeight
        } else {
            btnH = ht_height
        }
        
        for index in 0..<titleArray.count {
            let btn = UIButton(type: .custom)
            btnW = allWidth <= ht_width ? ht_width / CGFloat(titleArray.count) : ((width(str: titleArray[index], font: config.titleFont) + config.titleSpacing))
            btn.frame = CGRect(x: btnX, y: 0, width: btnW, height: btnH)
            btnX += btnW
            btn.tag = index
            btn.titleLabel?.font = config.titleFont
            btn.setTitle(titleArray[index], for: .normal)
            btn.setTitleColor(config.titleColor, for: .normal)
            btn.setTitleColor(config.selectTitleColor, for: .selected)
            btn.addTarget(self, action: #selector(buttonAction(btn:)), for: .touchUpInside)
            btnArray.append(btn)
            scroll.addSubview(btn)
        }
        scroll.contentSize = allWidth <= ht_width ? CGSize(width: ht_width, height: 0) : CGSize(width: (btnArray.last?.ht_right)! + 10, height: 0)
    }
}

//MARK: ^^^^^^^^^^^^^^^ 联动滚动 ^^^^^^^^^^^^^^^
extension HTScrollTitleView {
    
    ///
    
}

//MARK: ^^^^^^^^^^^^^^^ openMethod ^^^^^^^^^^^^^^^
extension HTScrollTitleView {
    
    /// 滚动标题到指定index
    open func scrollTo(index: Int) {
        if index == selectIndex {
            return
        }
        let btn = btnArray[index]
        tempBtn?.isSelected = false
        btn.isSelected = true
        selectBtnToCenter(btn: btn)
        changeIndicatorPositionTo(btn: btn)
        tempBtn = btn
        selectIndex = index
    }
    
    ///
    
}

