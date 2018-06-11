//
//  HTTableViewExtension.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/18.
//  Copyright © 2017 HT. All rights reserved.
//

import Foundation
import UIKit


extension UITableView{
    
    
    /// 创建一个tableView style默认为plain
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - w: w
    ///   - h: h
    ///   - style: tableStyle
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, style: UITableView.Style = .plain) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h), style: style)
    }
    
    /// 创建一个tableView
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - w: w
    ///   - h: h
    ///   - style: tableStyle
    /// - Returns: tableView
    class func ht_init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, style: UITableView.Style = .plain) -> UITableView{
        let table: UITableView?
        
        if isIphoneX {
            if h <= SCREEN_H - 88.0 {
                table = UITableView(x: x, y: y, w: w, h: h, style: style)
                return table!
            }else{
                table = UITableView(x: x, y: y, w: w, h: h, style: style)
                return table!
            }
        }else{
            if h <= SCREEN_H - 64.0 {
                table = UITableView(x: x, y: y, w: w, h: h, style: style)
                return table!
            }else{
                table = UITableView(x: x, y: y, w: w, h: h, style: style)
                return table!
            }
        }
    }
    
    /// 设置cell的分割线
    ///
    /// - Parameters:
    ///   - style: 分割线风格(系统)  (默认为.none)
    ///   - separatorColor: 分割线颜色   (默认为黑色)
    ///   - backGroundColor: table的背景色  (默认白色)
    public func ht_set(separatorStyle: UITableViewCell.SeparatorStyle = .none, separatorColor: UIColor = .black, backGroundColor: UIColor = .white){
        self.backgroundColor = backGroundColor
        if separatorStyle == .none {
            return
        }
        self.separatorStyle = separatorStyle
        self.separatorColor = separatorColor
    }
    
    /// 为tableView设置代理和数据源
    ///
    /// - Parameters:
    ///   - delegate: delegate
    ///   - dataSource: 数据源
    public func ht_set(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
}




