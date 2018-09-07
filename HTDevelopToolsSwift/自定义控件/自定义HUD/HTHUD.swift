//
//  HTHUD.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/6/13.
//  Copyright © 2018年 HT. All rights reserved.
//



import UIKit

//  constants
fileprivate let defaultTextFontSize: CGFloat = 14.0
fileprivate let defaultTextColor: UIColor = .black

fileprivate let Screen_W = UIScreen.main.bounds.width
fileprivate let Screen_H = UIScreen.main.bounds.height

fileprivate let hudMax_W = Screen_W * 0.75
fileprivate let hudMin_W: CGFloat = 100

fileprivate let animatedTime: Double = 0.35

/// hud`s activityView config struct
struct HUDActivityViewConfig {
    
    init() {
    }
    
    var tintColor: UIColor = .white
    
    var backgroundColor: UIColor = .gray
    
}

/// HUD
class HTHUD: UIView {
    
    /// animated style enum
    public enum HUDAnimatedStyle {
        case fade
        case zoom
        case caseOut
        case caseIn
    }
    
    /// HUD background style enum
    public enum HUDBackgroundStyle {
        case light
        case dark
    }
    
    /// HUD mod enum
    public enum HUDMod {
        case text
        case custom
        case progress
        case textAndProgress
        
    }
    
    /*****      private properties      ******/
    
    /// is use animated, default is true
    private var isAnimate = true
    
    /// removeHUD when hide, default is true
    private var isRemoveHudWhenHide = true
    
    /// bezelView
    private var bezelView: HTHUDBackGroundView!
    
    /// ActivityView
    private var activityView: UIActivityIndicatorView?
    
    /// Timer
    private var timer: Timer?
    
    /**************************/
    
    
    /*****      open properties      ******/
    
    /// HUD show time, default is 1S
    open var timeValue: Double = 1
    
    /// HUD show or hide style, default is fade
    open var animatedStyle: HTHUD.HUDAnimatedStyle = .fade
    
    /// background style, default is light
    open var backgroundStyle: HTHUD.HUDBackgroundStyle = .light
    
    /// hudmod, default is text
    open var mod: HTHUD.HUDMod = .progress
    
    /// u customView, if HUD.mod is custom to take effect
    open var customView: UIView?
    
    /// activityConfig
    open var activityConfig: HUDActivityViewConfig?
    
    /**************************/
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: Screen_W, height: Screen_H))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        uploadConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// setUp UI
    private func setUp() {
        bezelView = HTHUDBackGroundView(style: .progress, backgroundStyle: .light)
        bezelView.center = CGPoint(x: Screen_W / 2, y: Screen_H / 2)
        bezelView.bounds = CGRect(x: 0, y: 0, width: hudMin_W, height: hudMin_W)
        bezelView.layer.cornerRadius = 5
        bezelView.clipsToBounds = true
        addSubview(bezelView)
        
        switch mod {
        case .text:
            break
        case .custom:
            break
        case .progress:
            activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityView?.center = CGPoint(x: hudMin_W / 2, y: hudMin_W / 2)
            bezelView.contentView.addSubview(activityView!)
            break
        case .textAndProgress:
            break
        }
        
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    /// upload config
    private func uploadConfig() {
        guard let activity = activityConfig else { return }
        activityView?.color = activity.tintColor
        activityView?.backgroundColor = activity.backgroundColor
//        guard let <#constant#> = <#expression#> else { return <#return value#> }
    }
    
    private func show(animated: Bool) {
        activityView?.startAnimating()
        timer = Timer(timeInterval: timeValue, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
        isAnimate = animated
        if animated {
            switch animatedStyle {
            case .fade:
                bezelView.alpha = 0
                UIView.animate(withDuration: animatedTime, animations: {
                    self.bezelView.alpha = 1
                }) { (finish) in
                }
            default:
                break
            }
        }
    }
    
    private func hide() {
        timer?.invalidate()
        UIView.animate(withDuration: animatedTime, animations: {
            self.bezelView.alpha = 0
        }) { (finish) in
            if finish {
                self.removeFromSuperview()
                self.timer = nil
            }
        }
    }
    
    @objc private func timerAction() {
        hide()
    }
}

//MARK: ^^^^^^^^^^^^^^^ class method ^^^^^^^^^^^^^^^
extension HTHUD {
    
    
    class func show(with text: String, animated: Bool) {
        let hud = HTHUD()
        hud.show(animated: animated)
    }
    
    class func showProgress(animated: Bool) {
        let hud = HTHUD()
        hud.show(animated: animated)
    }
    
}







/// HUDBackGroundView
class HTHUDBackGroundView: UIVisualEffectView {
    
    open var background: UIColor = .red {
        didSet {
            contentView.backgroundColor = background
        }
    }
    
    private var viewStyle: HTHUD.HUDMod = .progress
    private var backgroundStyles: HTHUD.HUDBackgroundStyle = .light
    
    convenience init(style: HTHUD.HUDMod = .progress, backgroundStyle: HTHUD.HUDBackgroundStyle = .light) {
        self.init(frame: .zero)
        viewStyle = style
        backgroundStyles = backgroundStyle
        setUp()
    }
    
    private func setUp() {
        switch backgroundStyles {
        case .light:
            let effect = UIBlurEffect(style: .extraLight)
            self.effect = effect
        case .dark:
            let effect = UIBlurEffect(style: .dark)
            self.effect = effect
        }
        
    }
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










