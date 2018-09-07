//
//  Controllers.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/6/21.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class Controllers: HTCustomNavController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    lazy var dataSource = [["name":"我的标签",
                            "array": [
                                ["typeName": "#",
                                 "color": UIColor.black,
                                 "tagArr": ["懒猪",
                                            "吃货",
                                            "女神",
                                            "强迫症晚期"
                                            ]
                                    ]
                                ]
                            ],
                           ["name": "我的兴趣",
                            "array": [
                                ["typeName": "🏌",
                                 "color": UIColor.green,
                                 "tagArr": ["乒乓球",
                                            "高尔夫",
                                            "篮球",
                                            "铅球",
                                            "长跑"
                                    ]
                                ],
                                ["typeName": "🎵",
                                 "color": UIColor.purple,
                                 "tagArr": ["嘻哈",
                                            "摇滚",
                                            "民谣",
                                            "抒情",
                                            "欧美",
                                            "陈奕迅"
                                    ]
                                ],
                                ["typeName": "🍴",
                                 "color": UIColor.red,
                                 "tagArr": ["牛排",
                                            "烧烤",
                                            "火锅",
                                            "日式r铁板烧",
                                            "韩国烤肉",
                                            "麻辣香锅",
                                            "日本拉面",
                                            "蛋糕甜点"
                                    ]
                                ],
                                ["typeName": "🎬",
                                 "color": UIColor.blue,
                                 "tagArr": ["当幸福来敲门",
                                            "金三胖的总统之路",
                                            "普金大帝自传",
                                            "川不靠谱的职场生活",
                                            "铁血书生郭沫若",
                                            "从善如流马歇尔",
                                            "小鬼当家",
                                            "听海",
                                            "看",
                                            "前任",
                                            "这个杀手不太冷",
                                            "泰坦尼克号",
                                            "灵魂三部曲"
                                    ]
                                ]
                                ]
                           ]
                          ]
    
    lazy var table = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H - (isIphoneX ? 88 : 64)), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainBgViewColor = .green
        navColor = .cyan
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panAction(pan:)))
        pan.edges = .right
        view.addGestureRecognizer(pan)
        
        table.register(TagCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = ht_H(100)
        BGView.addSubview(table)
        
        // Do any additional setup after loading the view.
    }
    var startPointY: CGFloat = 0
    var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    var interacting = false
    var scale: CGFloat = 0
    @objc func panAction(pan: UIScreenEdgePanGestureRecognizer) {
        
        if pan.state == .began {
            let startPoint = pan.location(in: UIApplication.shared.keyWindow!)
            scale = 1 - startPoint.x / SCREEN_W
            interacting = true
            /// 手势开始时实例化手势驱动对象 改变标记
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewController(animated: true)
        } else if pan.state == .changed {
            let currentPoint = pan.location(in: UIApplication.shared.keyWindow!)
            
            scale = 1 - (currentPoint.x) / SCREEN_W
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

extension Controllers: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        /// 根据手势标记状态返回
        return interacting ? percentDrivenTransition : nil
    }
    
}

extension Controllers: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as! Controllers
        let toVC = transitionContext.viewController(forKey: .to) as! RootViewContro
        
        let containerView = transitionContext.containerView
        let toView = toVC.view!
        toView.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H)
        let fromView = fromVC.view!
        fromView.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H)
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.frame = CGRect(x: -SCREEN_W, y: 0, width: SCREEN_W, height: SCREEN_H)
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}

extension Controllers: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = dataSource[section]
        let arr = model["array"] as! Array<Any>
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = table.dequeueReusableCell(withIdentifier: "cell") as? TagCell
        
        if cell == nil {
            cell = TagCell(style: .default, reuseIdentifier: "cell")
        }
        
        return cell!
    }
    
    
    
    
}
