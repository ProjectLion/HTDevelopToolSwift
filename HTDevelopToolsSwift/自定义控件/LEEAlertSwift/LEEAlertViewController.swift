//
//  LEEAlertViewController.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/2/1.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEEAlertViewController: LEEBaseViewController {
    
    public var containerView: UIView!
    
    public var alertView: UIScrollView!
    
    public var alertItemArray: [Any]?
    
    public var alertActionArray: [LEEActionButton]?
    
    private var alertViewHeight: CGFloat?
    private var keyborderFrame: CGRect?
    private var isShowingKeyboard: Bool?
    
    deinit {
        self.alertView = nil
        self.alertItemArray = nil
        self.alertActionArray = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNotification()
//        self.con
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notify:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc private func keyboardWillChangeFrame(notify: Notification) {
        
        if self.config?.modelIsAvoidKeyboard != nil {
            if self.config?.modelIsAvoidKeyboard! == true {
                let duration = notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
                keyborderFrame = (notify.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect)
                
                isShowingKeyboard = (keyborderFrame?.origin.y)! < UIScreen.main.bounds.height
                
                UIView.beginAnimations("keyboardWillChangeFrame", context: nil)
                
                UIView.setAnimationDuration(duration)
                
                self.updateAlertLayout()
                
                UIView.commitAnimations()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isShowing == false && self.isClosing == false {
            self.updateAlertLayout()
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        self.updateAlertLayout()
    }
    
    private func updateAlertLayout() {
        self.updateAlertLayout(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    private func updateAlertLayout(width: CGFloat, height: CGFloat) {
        let alertViewMaxWidth = self.config?.modelMaxWidthBlock(self.orientationType!)
        let alertViewMaxHeight = self.config?.modelMaxHeightBlock(self.orientationType!)
        
        if isShowingKeyboard != nil {
            if isShowingKeyboard == true {
                if keyborderFrame?.size.height != 0 {
                    
                    self.updateAlertItemsLayout()
                    
                    let keyborderY = keyborderFrame?.origin.y
                    
                    var alertViewFrame = self.alertView?.frame
                    
                    let tempAlertViewHeight = keyborderY! - alertViewHeight! < 20 ? keyborderY! - 20 : alertViewHeight!
                    
                    let tempAlertViewY = keyborderY! - tempAlertViewHeight - 10;
                    
                    let originalAlertViewY = (height - (alertViewFrame?.size.height)!) * 0.5
                    
                    alertViewFrame?.size.height = tempAlertViewHeight
                    
                    alertViewFrame?.size.width = alertViewMaxWidth!
                    
                    self.alertView?.frame = alertViewFrame!
                    
                    var containerFrame = self.containerView?.frame
                    
                    containerFrame?.size.width = (alertViewFrame?.size.width)!
                    containerFrame?.size.height = (alertViewFrame?.size.height)!
                    
                    containerFrame?.origin.x = (width - (alertViewFrame?.size.width)!) * 0.5
                    
                    containerFrame?.origin.y = tempAlertViewY < originalAlertViewY ? tempAlertViewY : originalAlertViewY
                    
                    self.containerView?.frame = containerFrame!
                    
                    self.alertView?.scrollRectToVisible((self.findFirstResponder(view: self.alertView!)?.frame)!, animated: true)
                }
            }else{
                self.updateAlertItemsLayout()
                
                var alertViewFrame = self.alertView?.frame
                
                alertViewFrame?.size.width = alertViewMaxWidth!
                
                alertViewFrame?.size.height = alertViewHeight! > alertViewMaxHeight! ? alertViewMaxHeight! : alertViewHeight!
                
                self.alertView?.frame = alertViewFrame!;
                
                var containerFrame = (self.containerView?.frame)!;
                
                containerFrame.size.width = (alertViewFrame?.size.width)!
                
                containerFrame.size.height = (alertViewFrame?.size.height)!
                
                containerFrame.origin.x = (width - alertViewMaxWidth!) * 0.5
                
                containerFrame.origin.y = (height - (alertViewFrame?.size.height)!) * 0.5
                
                self.containerView?.frame = containerFrame;
                
            }
        }
        
    }
    
    private func updateAlertItemsLayout() {
        UIView.setAnimationsEnabled(false)
        
        alertViewHeight = 0;
        
        let alertViewMaxWidth = self.config?.modelMaxWidthBlock(self.orientationType!)
        
        (self.alertItemArray as NSArray?)?.enumerateObjects { (item, idx, stop) in
            if idx == 0 {
                alertViewHeight = alertViewHeight! + (self.config?.modelHeaderInsets?.top)!
            }
            
            if item is UIView {
                let view = item as! LEEItemView
                
                var viewFrame = view.frame
                
                viewFrame.origin.x = (self.config?.modelHeaderInsets?.left)! + (view.item?.insets.left)! + self.viewSafeEareaInsets(view: view).left
                
                viewFrame.origin.y = alertViewHeight! + (view.item?.insets.top)!
                
                viewFrame.size.width = alertViewMaxWidth! - viewFrame.origin.x - (self.config?.modelHeaderInsets?.right)! - (view.item?.insets.right)! - self.viewSafeEareaInsets(view: view).left - self.viewSafeEareaInsets(view: view).right
                
                if item is UILabel {
                    
                    viewFrame.size.height = (item as! UILabel).sizeThatFits(CGSize(width: viewFrame.size.width, height: CGFloat(MAXFLOAT))).height
                    
                }
                
                view.frame = viewFrame
                
                alertViewHeight = alertViewHeight! + view.frame.size.height + (view.item?.insets.top)! + (view.item?.insets.bottom)!
                
            }else if item is LEECustomView {
                
                let custom = item as! LEECustomView
                
                var viewFrame = custom.view?.frame;
                
                if custom.isAutoWidth! == true {
                    
                    custom.positionType = .Center
                    
                    viewFrame?.size.width = alertViewMaxWidth! - (self.config?.modelHeaderInsets?.left)! - (custom.item?.insets.left)! - (self.config?.modelHeaderInsets?.right)! - (custom.item?.insets.right)!
                }
                
                switch custom.positionType {
                    
                case .Center:
                    
                    viewFrame?.origin.x = (alertViewMaxWidth! - (custom.view?.frame.size.width)!) * 0.5
                    
                    break;
                    
                case .Left:
                    
                    viewFrame?.origin.x = (self.config?.modelHeaderInsets?.left)! + (custom.item?.insets.left)!;
                    
                    break;
                    
                case .Right:
                    
                    viewFrame?.origin.x = alertViewMaxWidth! - (self.config?.modelHeaderInsets?.right)! - (custom.item?.insets.right)! - (custom.view?.frame.size.width)!
                    
                    break;
                }
                viewFrame?.origin.y = alertViewHeight! + (custom.item?.insets.top)!
                
                custom.view?.frame = viewFrame!
                
                alertViewHeight = alertViewHeight! + (viewFrame?.size.height)! + (custom.item?.insets.top)! + (custom.item?.insets.bottom)!
            }
            
            if item as! _OptionalNilComparisonType == self.alertItemArray?.last! {
                alertViewHeight = alertViewHeight! + (self.config?.modelHeaderInsets?.bottom)!
            }
        }
        
        for button in self.alertActionArray! {
            var buttonFrame = button.frame;
            
            buttonFrame.origin.x = (button.action?.insets?.left)!;
            
            buttonFrame.origin.y = alertViewHeight! + (button.action?.insets?.top)!;
            
            buttonFrame.size.width = alertViewMaxWidth! - (button.action?.insets?.left)! - (button.action?.insets?.right)!;
            
            button.frame = buttonFrame;
            
            alertViewHeight = alertViewHeight! + buttonFrame.size.height + (button.action?.insets?.top)! + (button.action?.insets?.bottom)!;
        }
        
        if self.alertActionArray?.count == 0 {
            let buttonA = (self.alertActionArray?.count == self.config?.modelActionArray?.count) ? self.alertActionArray?.last! : self.alertActionArray?.first!
            
            let buttonB = (self.alertActionArray?.count == self.config?.modelActionArray?.count) ? self.alertActionArray?.first! : self.alertActionArray?.last!
            
            let buttonAInsets = buttonA?.action?.insets!
            let buttonBInsets = buttonB?.action?.insets!
            
            let buttonAHeight = (buttonA?.frame.size.height)! + (buttonAInsets?.top)! + (buttonAInsets?.bottom)!
            let buttonBHeight = (buttonB?.frame.size.height)! + (buttonBInsets?.top)! + (buttonBInsets?.bottom)!
            
            let minHeight = buttonAHeight < buttonBHeight ? buttonAHeight : buttonBHeight
            
            let minY = ((buttonA!.frame.origin.y - (buttonAInsets?.top)!) > ((buttonB?.frame.origin.y)! - (buttonBInsets?.top)!)) ? ((buttonB?.frame.origin.y)! - (buttonBInsets?.top)!) : ((buttonA?.frame.origin.y)! - (buttonAInsets?.top)!)
            
            buttonA!.frame = CGRect(x: buttonAInsets!.left, y: minY + (buttonAInsets?.top)!, width: (alertViewMaxWidth! / 2) - (buttonAInsets?.left)! - (buttonAInsets?.right)!, height: (buttonA?.frame.size.height)!)
            
            buttonB!.frame = CGRect(x: (alertViewMaxWidth! / 2) + buttonBInsets!.left, y: minY + buttonBInsets!.top, width: (alertViewMaxWidth! / 2) - (buttonBInsets?.left)! - (buttonBInsets?.right)!, height: (buttonB?.frame.size.height)!);
            
            alertViewHeight = alertViewHeight! - minHeight;
        }
        
        self.alertView?.contentSize = CGSize(width: alertViewMaxWidth!, height: alertViewHeight!)
        
        UIView.setAnimationsEnabled(true)
    }
    
    private func configAlert() {
        
        weak var weakSelf = self
        
        self.containerView = UIView()
        
        self.view.addSubview(self.containerView)
        
        self.containerView.addSubview(self.alertView)
        
        self.containerView.layer.shadowOffset = (self.config?.modelShadowOffset)!
        
        self.containerView.layer.shadowRadius = (self.config?.modelShadowRadius)!
        
        self.containerView.layer.shadowOpacity = Float((self.config?.modelShadowOpacity)!)
        
        self.containerView.layer.shadowColor = (self.config?.modelShadowColor)!.cgColor
        
        self.alertView.layer.cornerRadius = (self.config?.modelCornerRadius)!
        
        (self.config?.modelItemArray as NSArray?)?.enumerateObjects({ (objc, idx, stop) in
            
            let itemBlock: (LEEItem) -> () = objc as! (LEEItem) -> ()
            
            let item = LEEItem()
            
            itemBlock(item)
            
            let insetValue: NSValue = self.config?.modelItemInsetsInfo!["\(idx)"] as! NSValue
            
            item.insets = insetValue.uiEdgeInsetsValue
            
            switch item.type {
            case .Title:
                let block: (_ label: UILabel) -> () = item.viewBlock
                
                let label = LEEItemLabel.label()
                
                self.alertView.addSubview(label)
                self.alertItemArray?.append(label)
                
                label.textAlignment = .center
                label.font = UIFont.boldSystemFont(ofSize: 17)
                label.textColor = .black
                label.numberOfLines = 0
                block(label)
                label.item = item
                label.textChangedBlock = {
                    () -> () in
                    weakSelf?.updateAlertLayout()
                }
                
            case .Content:
                let block: (_ label: UILabel) -> () = item.viewBlock
                
                let label = LEEItemLabel.label()
                
                self.alertView.addSubview(label)
                self.alertItemArray?.append(label)
                
                label.textAlignment = .center
                label.font = UIFont.boldSystemFont(ofSize: 14)
                label.textColor = .black
                label.numberOfLines = 0
                block(label)
                label.item = item
                label.textChangedBlock = {
                    () -> () in
                    weakSelf?.updateAlertLayout()
                }
            case .TextField:
                
                let textField = LEEItemTextField.textField()
                
                self.alertView.addSubview(textField)
                self.alertItemArray?.append(textField)
                
                textField.borderStyle = .roundedRect
                
                let block: (_ textField: UITextField) -> () = item.viewBlock
                
                block(textField)
                
                textField.item = item
                
            case .CustomView:
                let block: (_ customView: LEECustomView) -> () = item.viewBlock
                
                let custom = LEECustomView()
                
                block(custom)
                
                self.alertView.addSubview(custom.view!)
                self.alertItemArray?.append(custom)
                
                custom.item = item
                custom.sizeChangedBloack = {
                    () -> Swift.Void in
                    weakSelf?.updateAlertLayout()
                }
            }
            
        })
        
        (self.config?.modelActionArray as NSArray?)!.enumerateObjects { (item, idx, stop) in
            let block: (_ action: LEEAction) -> () = item as! (LEEAction) -> ()
            
            let action = LEEAction()
            
            block(action)
            
            if action.font == nil {
                action.font = UIFont.systemFont(ofSize: 17)
            }
            
            if action.title == nil {
                action.title = "这是按钮"
            }
            
            if action.titleColor == nil {
                action.titleColor = UIColor(red: 21.0 / 255.0, green: 123.0 / 255.0, blue: 245.0 / 255.0, alpha: 1)
            }
            
            if action.backgroundColor == nil {
                action.backgroundColor = self.config?.modelHeaderColor!
            }
            
            if action.backgroundHighlightColor == nil {
                action.backgroundHighlightColor = UIColor(white: 0.96, alpha: 1)
            }
            
            if action.borderColor == nil {
                action.borderColor = UIColor(white: 0.83, alpha: 1)
            }
            
            if action.borderWidth == nil {
                action.borderWidth = (1 / UIScreen.main.scale) + 0.02
            }
            
            if action.borderPosition != .Top {
                if self.config?.modelActionArray?.count == 2 && idx == 0 {
                    action.borderPosition = .Right
                }
            }
            
            if action.height == nil {
                action.height = 45
            }
            
            let button = LEEActionButton.button()
            button.action = action
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            self.alertView.addSubview(button)
            self.alertActionArray?.append(button)
            
            button.heightChangeBlock = {
                () -> () in
                weakSelf?.updateAlertLayout()
                return
            }
        }
        self.updateAlertLayout()
//        self.show
    }
    
    @objc private func buttonAction(sender: UIButton) {
        
        var isClose = false
        
        var clickBlock = {
            () -> Swift.Void in
            return
        }
        
        for button in self.alertActionArray! {
            if button == sender {
                
                switch button.action?.type {
                    
                case .Default?:
                    isClose = (button.action?.isClickNotClose)! ? false : true
                case .Cancel?:
                    isClose = true
                case .Destructive?:
                    isClose = true
                default:
                    break
                }
                
                clickBlock = (button.action?.clickBlock)!
                break
            }
        }
        if isClose == true {
            
        }
    }
    
    private func findFirstResponder(view: UIView) -> UIView? {
        
        if view.isFirstResponder {
            return view
        }
        
        for subView in view.subviews {
            let firstResponder = self.findFirstResponder(view: subView)
            
            if firstResponder != nil {
                return firstResponder
            }
        }
        return nil
    }
    
    private func viewSafeEareaInsets(view: UIView) -> UIEdgeInsets {
        
        var i = UIEdgeInsets()
        
        if #available(iOS 11.0, *) {
            i = view.safeAreaInsets
        }else{
            i = .zero
        }
        return i
    }
    
    override func showAnimationsWith(block: @escaping () -> ()) {
        super.showAnimationsWith(block: block)
        if self.isShowing! == true {
            return
        }
        self.isShowing = true
        
        let viewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        
        var containerFrame = self.containerView.frame
        let containerH = containerFrame.size.height
        let containerW = containerFrame.size.width
        
        switch self.config?.modelOpenAnimationStyle {
        case .None?:
            containerFrame.origin.x = (viewWidth - containerW) * 0.5
            containerFrame.origin.y = (viewHeight - containerH) * 0.5
        case .Top?:
            containerFrame.origin.x = (viewWidth - containerW) * 0.5
            containerFrame.origin.y = (0 - containerH)
        case .Bottom?:
            containerFrame.origin.x = (viewWidth - containerW) * 0.5
            containerFrame.origin.y = viewHeight
        case .Left?:
            containerFrame.origin.x = 0 - containerW
            containerFrame.origin.y = (viewHeight - containerH) * 0.5
        case .Right?:
            containerFrame.origin.x = viewWidth
            containerFrame.origin.y = (viewHeight - containerH) * 0.5
        case .Fade?:
            self.containerView.alpha = 0
        case .ZoomEnlarge?:
            self.containerView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        case .ZoomShrink?:
            self.containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        default:
            break
        }
        self.containerView.frame = containerFrame
        
        weak var WeakSelf = self
        
        if self.config?.modelOpenAnimationBlock != nil {
            self.config?.modelOpenAnimationBlock({
                if WeakSelf == nil {
                    return
                }
                
                if WeakSelf?.config?.modelBackgroundStyle == .Blur {
                    
                    WeakSelf?.backgroundVisualEffectView?.effect = UIBlurEffect(style: (WeakSelf?.config?.modelBackgroundBlurEffectStyle)!)
                    
                }else if WeakSelf?.config?.modelBackgroundStyle == .Translucent {
                    
                    WeakSelf?.view.backgroundColor = UIColor().withAlphaComponent((WeakSelf?.config?.modelBackgroundStyleColorAlpha)!)
                    
                }
                
                var containerFrame = WeakSelf?.containerView.frame
                let containerH = containerFrame?.size.height
                let containerW = containerFrame?.size.width
                
                containerFrame?.origin.x = (viewWidth - containerW!) * 0.5
                containerFrame?.origin.y = (viewHeight - containerH!) * 0.5
                
                WeakSelf?.containerView.frame = containerFrame!
                WeakSelf?.containerView.alpha = 1.0
                WeakSelf?.containerView.transform = .identity
                
            }, {
                if WeakSelf == nil {
                    return
                }
                WeakSelf?.isShowing = false
                
                WeakSelf?.view.isUserInteractionEnabled = true
                
                if WeakSelf?.openFinishBlock != nil {
                    WeakSelf?.openFinishBlock()
                }
                
                block()
                
            })
            
        }
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
