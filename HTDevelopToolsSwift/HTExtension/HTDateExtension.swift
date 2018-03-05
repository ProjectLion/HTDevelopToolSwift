//
//  HTDateExtension.swift
//  HTDevelopTool_Swift
//
//  Created by apple on 2017/12/18.
//  Copyright © 2017年 HT. All rights reserved.
//

import Foundation

/**
 *   properties
 */
extension Date{
    
    /// 根据时间获取年
    public var ht_Year: Int {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self).year!
    }
    
    
    /// 根据时间获取月份
    public var ht_Month: Int {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self).month!
    }
    
    
    /// 根据时间获取日期
    public var ht_Day: Int {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self).day!
    }
    
    
    /// 根据时间获取时
    public var ht_Hour: Int {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self).hour!
    }
    
    
    /// 根据时间获取分
    public var ht_Minute: Int {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self).minute!
    }
    
    
    /// 根据时间获取秒
    public var ht_Second: Int {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self).second!
    }
    
    
}

/**
 *   Method
 */
extension Date{
    /// 根据时间获取年
    ///
    /// - Parameter date: 时间
    /// - Returns: 年份
    func ht_getYear() -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.year!
    }
    
    /// 根据时间获取月份
    ///
    /// - Parameter date: 时间
    /// - Returns: 月份
    func ht_getMonth() -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.month!
    }
    
    /// 根据时间获取日期
    ///
    /// - Parameter date: 时间
    /// - Returns: 日期
    func ht_getDay() -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.day!
    }
    
    /// 根据时间获取时
    ///
    /// - Parameter date: 时间
    /// - Returns: 时
    func ht_getHour() -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.hour!
    }
    
    /// 根据时间获取分
    ///
    /// - Parameter date: 时间
    /// - Returns: 分钟
    func ht_getMinute() -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.minute!
    }
    
    /// 根据时间获取秒
    ///
    /// - Parameter date: 时间
    /// - Returns: 秒
    func ht_getSecond() -> Int{
        let component: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
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
    
    /// 将时间字符串转为时间
    ///
    /// - Parameters:
    ///   - dateString: 时间字符串
    ///   - format: 时间格式
    /// - Returns: 时间
    static func ht_transformStringToDate(dateString: String, format:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.date(from: format)
        let date = dateFormatter.date(from: dateString)
        return date!
    }
}

