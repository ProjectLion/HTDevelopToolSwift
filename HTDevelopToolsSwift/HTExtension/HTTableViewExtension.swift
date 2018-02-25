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
    /// 创建一个tableView
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - w: w
    ///   - h: h
    ///   - style: tableStyle
    /// - Returns: tableView
    class func ht_initTableWith(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, style: UITableViewStyle) -> UITableView{
        let table: UITableView?
        
        if isIphoneX {
            if h <= SCREEN_H - 88.0 {
                table = UITableView(frame: CGRect(x: x, y: y, width: w, height: h), style: style)
                return table!
            }else{
                table = UITableView(frame: CGRect(x: x, y: y, width: w, height: h - 88.0), style: style)
                return table!
            }
        }else{
            if h <= SCREEN_H - 64.0 {
                table = UITableView(frame: CGRect(x: x, y: y, width: w, height: h), style: style)
                return table!
            }else{
                table = UITableView(frame: CGRect(x: x, y: y, width: w, height: h - 64.0), style: style)
                return table!
            }
        }
    }
    
    /// 设置cell的分割线
    ///
    /// - Parameters:
    ///   - style: 分割线风格(系统)  (默认为.none)
    ///   - separatorColor: 分割线颜色
    ///   - backGroundColor: table的背景色  (默认白色)
    func ht_setTableSeparatorWith(style: UITableViewCellSeparatorStyle?, separatorColor: UIColor?, backGroundColor: UIColor?){
        if style == nil || style == .none{
            self.separatorStyle = .none
            return
        }
        if backGroundColor == nil {
            self.backgroundColor = UIColor.white
        }
        self.separatorStyle = style!
        self.separatorColor = separatorColor!
        self.backgroundColor = backGroundColor!
    }
    
}




