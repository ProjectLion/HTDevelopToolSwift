//
//  HTStringExtension.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/15.
//  Copyright © 2017年 HT. All rights reserved.
//

import Foundation

extension String{
    
    /// 获取字符串长度
    ///
    /// - Returns: 长度
    func ht_length() -> Int {
        return (self as NSString).length
    }
    
    /// 是否包含空格
    ///
    /// - Returns: 是否包含 
    func ht_isContainSpace() -> Bool{
        let range = (self as NSString).range(of: " ")
        
        if range.location != NSNotFound {
            return true
        }
        return false
    }
    
    /********************正则判断*******************/
    /// 正则相关
    private func ht_isValidateBy(regex: String) -> Bool{
        let predicate = NSPredicate(format: "SELF MATCHES " + regex)
        return predicate.evaluate(with: self)
    }
    /// 是否是手机号 分服务商
    func ht_isMobileNumberClassification() -> Bool{
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
         * 联通：130,131,132,152,155,156,185,186,1709
         * 电信：133,1349,153,180,189,1700
         */
        //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
        
        /**
         10         * 中国移动：China Mobile
         11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
         12         */
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$"
        /**
         15         * 中国联通：China Unicom
         16         * 130,131,132,152,155,156,185,186,1709
         17         */
        let CU = "^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$"
        /**
         20         * 中国电信：China Telecom
         21         * 133,1349,153,180,189,1700
         22         */
        let CT = "^1((33|53|8[09])\\d|349|700)\\d{7}$"
        
        
        /**
         25         * 大陆地区固话及小灵通
         26         * 区号：010,020,021,022,023,024,025,027,028,029
         27         * 号码：七位或八位
         28         */
        let PHS = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        
        
        //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        
        if self.ht_isValidateBy(regex: CM)
            || self.ht_isValidateBy(regex: CU)
            || self.ht_isValidateBy(regex: CT)
            || self.ht_isValidateBy(regex: PHS)
        {
            return true
        }else{
            return false
        }
    }
    /// 是否是手机号
    func ht_isMobileNumber() -> Bool{
        let regex = "^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$"
        return self.ht_isValidateBy(regex: regex)
    }
    /// 是否是邮箱号
    func ht_isEmail() -> Bool{
        let regex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return self.ht_isValidateBy(regex: regex)
    }
    /// 是否是身份证
    func ht_isIDCard() -> Bool{
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        return self.ht_isValidateBy(regex: regex)
    }
    /// 是否是车牌号
//    func ht_isCarNumber() -> Bool{
//        let regex = "^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$"
//        return self.ht_isValidateBy(regex: regex)
//    }
    /// 是否是网址
    func ht_isUrl() -> Bool{
        let regex = "^((http)|(https))+:[^\\s]+\\.[^\\s]*$"
        return self.ht_isValidateBy(regex: regex)
    }
    /// 是否是邮编
    func ht_isPostalcode() -> Bool{
        let regex = "^[0-8]\\d{5}(?!\\d)$";
        return self.ht_isValidateBy(regex: regex)
    }
}

extension String {
    /// 将”XX天XX小时XX分钟XX秒XX毫秒“格式的字符串转为时间戳
    ///
    /// - Parameter timeString: 时间字符串(其中的“天” or “小时” or “分钟” or “秒” 可没有,如“5小时43分钟20毫秒”)
    /// - Returns: 时间戳(毫秒)
    func ht_transformToTimeStamp() -> Int {
        /// 天
        var days = 0
        /// 时
        var hours = 0
        /// 分
        var minutes = 0
        /// 秒
        var seconds = 0
        /// 毫秒
        var milliseconds = 0
        
        var tempStr = self
        
        var strLength = tempStr.count
        
        // 找天
        if let dayIndex = findCharIndex(str: tempStr, char: "天") {
            let dayStr = String(tempStr.dropLast(strLength - dayIndex))
            days = Int(String(dayStr))!
            // 找到天以后拿掉天的字符串
            tempStr = String(tempStr.dropFirst(dayIndex + 1))
            strLength = tempStr.count
            ht_print(message: dayStr+"天")
        }
        
        // 找时
        if let hourIndex = findCharIndex(str: tempStr, char: "小") {
            let hourStr = String(tempStr.dropLast(strLength - hourIndex))
            hours = Int(hourStr)!
            // 找到时以后拿掉时的字符串
            tempStr = String(tempStr.dropFirst(hourIndex + 2))    // 加2是因为s小时两个字符
            strLength = tempStr.count
            ht_print(message: hourStr + "小时")
        }
        
        // 找分
        if let minuteIndex = findCharIndex(str: tempStr, char: "分") {
            let minuteStr = String(tempStr.dropLast(strLength - minuteIndex))
            minutes = Int(minuteStr)!
            // 找到分以后拿掉分的字符串
            tempStr = String(tempStr.dropFirst(minuteIndex + 2))
            strLength = tempStr.count
            ht_print(message: minuteStr + "分钟")
        }
        
        // 找秒
        if let secondIndex = findCharIndex(str: tempStr, char: "秒") {
            let secondeStr = String(tempStr.dropLast(strLength - secondIndex))
            seconds = Int(secondeStr)!
            // 找到秒以后拿掉秒的字符串
            tempStr = String(tempStr.dropFirst(secondIndex + 1))
            strLength = tempStr.count
            ht_print(message: secondeStr + "秒")
        }
        
        // 找毫秒
        if let millisecondIndex = findCharIndex(str: tempStr, char: "毫") {
            let millisecondStr = String(tempStr.dropLast(strLength - millisecondIndex))
            milliseconds = Int(millisecondStr)!
            ht_print(message: millisecondStr + "毫秒")
        }
        
        return (days*24*3600 + hours*3600 + minutes*60 + seconds)*1000 + milliseconds
    }
    
    /// 寻找某个字符在字符串中的位置
    fileprivate func findCharIndex(str: String, char: String) -> Int? {
        for (idx, item) in str.enumerated() {
            if String(item) == char {
                return idx
            }
        }
        return nil
    }
}








