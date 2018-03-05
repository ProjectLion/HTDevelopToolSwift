//
//  LEEBaseViewController.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2018/2/1.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class LEEBaseViewController: UIViewController {
    
    public var config: LEEAlertConfigModel?
    
    public lazy var currentKeyWindow: UIWindow = {
        () -> UIWindow in
        
        var window = UIWindow(frame: UIScreen.main.bounds)
        window = UIApplication.shared.keyWindow!
        
        if window.windowLevel != UIWindowLevelNormal {
//            let predicate = NSPredicate(format: "windowLevel == %ld AND hidden == 0", UIWindowLevelNormal)
            window = UIApplication.shared.windows.first!
        }
        
        if LEEAlert.share.mainWindow != nil {
            LEEAlert.share.mainWindow = window
        }
        
        return window
    }()
    
    public var backgroundVisualEffectView: UIVisualEffectView?
    
    public var orientationType: LEEScreenOrientationType?
    
    public var customView: LEECustomView?
    
    public var isShowing: Bool?
    
    public var isClosing:Bool?
    
    public var openFinishBlock: () -> ()?
    
    public var closeFinishBlock: () -> ()?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        openFinishBlock = {
            () -> () in
            return
        }
        
        closeFinishBlock = {
            () -> () in
            return
        }
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .all
        
        self.extendedLayoutIncludesOpaqueBars = false
        
//        self.automaticallyAdjustsScrollViewInsets = false
        if self.config?.modelBackgroundStyle == .Blur {
            self.backgroundVisualEffectView = UIVisualEffectView(effect: nil)
            
            self.backgroundVisualEffectView?.frame = self.view.frame
            
            self.view.addSubview(self.backgroundVisualEffectView!)
        }
        
        self.view.backgroundColor = self.config?.modelBackgroundColor?.withAlphaComponent(0)
        
        self.orientationType = self.view.frame.size.height > self.view.frame.size.width ? .Vertical : .Horizontal
        
        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
//        if self.backgroundVisualEffectView != nil {
//            self.backgroundVisualEffectView?.frame = self.view.frame
//        }
        guard let view = self.backgroundVisualEffectView else {
            return
        }
        view.frame = self.view.frame
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.orientationType = size.height > size.width ? .Vertical : .Horizontal
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if self.config?.modelIsClickBackgroundClose != nil {
//
//        }
        guard let _ = config?.modelIsClickBackgroundClose else {
            return
        }
//        self.closeFinishBlock
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func closeAnimations(block: () -> ()) {
        LEEAlert.share.leeWindow.endEditing(true)
    }
    
    public func showAnimationsWith(block: @escaping () -> ()) {
        self.currentKeyWindow.endEditing(true)
        self.view.isUserInteractionEnabled = false
    }
    
    fileprivate func shouldAutorotate() -> Bool {
        return (self.config?.modelIsShouldAutorotate!)!
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return (self.config?.modelSupportedInterfaceOrientations)!
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        config = nil
        backgroundVisualEffectView = nil
        customView = nil
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
