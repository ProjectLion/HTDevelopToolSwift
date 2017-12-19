//
//  HTDateExtension.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2017/12/18.
//  Copyright © 2017年 HT. All rights reserved.
//

import Foundation

extension Date{
    
    /// 根据时间获取年
    ///
    /// - Parameter date: 时间
    /// - Returns: 年份
    static func ht_getYearWith(date: Date) -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return component.year!
    }
    
    /// 根据时间获取月份
    ///
    /// - Parameter date: 时间
    /// - Returns: 月份
    static func ht_getMonthWith(date: Date) -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return component.month!
    }
    
    /// 根据时间获取日期
    ///
    /// - Parameter date: 时间
    /// - Returns: 日期
    static func ht_getDayWith(date: Date) -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return component.day!
    }
    
    /// 根据时间获取时
    ///
    /// - Parameter date: 时间
    /// - Returns: 时
    static func ht_getHourWith(date: Date) -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return component.hour!
    }
    
    /// 根据时间获取分
    ///
    /// - Parameter date: 时间
    /// - Returns: 分钟
    static func ht_getMinuteWith(date: Date) -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return component.minute!
    }
    
    /// 根据时间获取秒
    ///
    /// - Parameter date: 时间
    /// - Returns: 秒
    static func ht_getSecondWith(date: Date) -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return component.second!
    }
    
    /// 将时间转为时间字符串
    ///
    /// - Parameter date: 时间
    /// - Returns: 时间字符串
    static func ht_transformWith(date: Date) -> String{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return "\(component.year!)-\(component.month!)-\(component.day!) \(component.hour!)-\(component.minute!)-\(component.second!)"
    }
}



