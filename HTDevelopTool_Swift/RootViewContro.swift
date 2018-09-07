//
//  RootViewContro.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/6/22.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class RootViewContro: HTCustomNavController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    var cornerBtn = UIButton(type: .custom)
    
    @objc func cornerBtnAction() {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    var arr: Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerBtn.layer.cornerRadius = 25
        cornerBtn.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        cornerBtn.ht_set(backGroundColor: .red, state: .normal)
        cornerBtn.addTarget(self, action: #selector(cornerBtnAction), for: .touchUpInside)
        cornerBtn.clipsToBounds = true
        BGView.addSubview(cornerBtn)
        BGView.isUserInteractionEnabled = true
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panAction(pan:)))
        pan.edges = .left
        BGView.addGestureRecognizer(pan)
        // Do any additional setup after loading the view.
    }
    
    var startPointY: CGFloat = 0
    var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    var interacting = false
    var scale: CGFloat = 0
    let vc = Controllers(backImgString:"icon_discover_on", title: "ddd")
    /// 拖动手势响应方法
    @objc private func panAction(pan: UIScreenEdgePanGestureRecognizer) {
        if pan.state == .began {
            let startPoint = pan.location(in: view)
            startPointY = startPoint.x
            interacting = true
            /// 手势开始时实例化手势驱动对象 改变标记
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if pan.state == .changed {
            let currentPoint = pan.location(in: view)
            
            scale = (currentPoint.x - startPointY) / SCREEN_W
            
            percentDrivenTransition?.update(scale)
        } else if pan.state == .ended || pan.state == .cancelled {
            //            collection.isScrollEnabled = true
            if (scale > 0.3) {
                percentDrivenTransition?.finish()
            } else {
                percentDrivenTransition?.cancel()
            }
            scale = 0.0
            /// 手势取消或者结束时改变标记 将手势驱动对象置空
            interacting = false
            percentDrivenTransition = nil
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RootViewContro: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        /// 根据手势标记状态返回
        return interacting ? percentDrivenTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}

extension RootViewContro: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as! RootViewContro
        let toVC = transitionContext.viewController(forKey: .to) as! Controllers
        
        let containerView = transitionContext.containerView
        
        let fromView = fromVC.view
        fromView?.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H)
        let toView = toVC.view
        toView?.frame = CGRect(x: -SCREEN_W, y: 0, width: SCREEN_W, height: SCREEN_H)
        
        containerView.addSubview(fromView!)
        containerView.addSubview(toView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView?.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H)
//            toView?.alpha = 1
        }) { (finish) in
            if finish {
//                fromView?.alpha = 1
//                fromVC.cornerBtn.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
}
