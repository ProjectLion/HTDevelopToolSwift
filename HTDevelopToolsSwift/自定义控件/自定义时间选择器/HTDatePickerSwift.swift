//
//  HTDatePickerSwift.swift
//  HTDevelopTool_Swift
//
//  Created by HT on 2017/12/20.
//  Copyright © 2017年 HT. All rights reserved.
//

import UIKit

fileprivate let screen_w = UIScreen.main.bounds.width
fileprivate let screen_h = UIScreen.main.bounds.height


enum HTDatePickerStyle {
    case Y                      //年
    case YM                     //年月
    case YMD                    //年月日
    case YMDH                   //年月日 时
    case YMDHM                  //年月日 时分
    case YMDHMS                 //年月日 时分秒
}

protocol HTDatePickerDelegate {
    
    func clickEnsure(selectDate: String)
}

class HTDatePickerSwift: UIView {
    
    /***************公开给外部自定义控件的接口***************/
    
    /// 是否可选当前时间之前的时间(默认为不可选)
    open var isCanSelectBefore = false
    
    /// 取消按钮的字体颜色(默认为灰色)
    open var cancelTitleColor: UIColor = UIColor.gray{
        didSet{
            cancelBtn.setTitleColor(cancelTitleColor, for: .normal)
        }
    }
    
    /// 确定按钮的字体颜色(默认为蓝色)
    open var ensureTitleColor: UIColor = UIColor.blue{
        didSet{
            ensureBtn.setTitleColor(ensureTitleColor, for: .normal)
        }
    }
    
    /// 是否为按钮添加圆角边框(默认为不添加,如果为true,边框颜色默认为灰色)
    open var isShowBtnBorder: Bool = false{
        didSet{
            if isShowBtnBorder {
                cancelBtn.layer.borderWidth = 1.5
                cancelBtn.layer.borderColor = UIColor.gray.cgColor
                cancelBtn.layer.cornerRadius = 5
                cancelBtn.layer.masksToBounds = true
                ensureBtn.layer.borderWidth = 1.5
                ensureBtn.layer.borderColor = UIColor.gray.cgColor
                ensureBtn.layer.cornerRadius = 5
                ensureBtn.layer.masksToBounds = true
            }
        }
    }
    
    /// 重写父类的init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 创建一个自定义时间选择器
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - style: 时间选择器的风格
    convenience init(style: HTDatePickerStyle) {
        self.init(frame: CGRect(x: 0, y: screen_h, width: screen_w, height: screen_h))
        _style = style
        configData()
        creatView()
        scrollToCurrentDate()
    }
    
    /***************************************************/
    
    // MARK: 私有常量
    private let max_year = 2060
    private let min_year = 1970
    private let minute_second = 60
    private let hour_second = 3600
    private let day_second = 86400
    private let week_second = 604800
    private let year_second = 31556926
    
    // MARK: 私有数据存储容器
    private var yearArr: Array<Int> = []
    private var monthArr: Array<Int> = []
    private var dayArr: Array<Int> = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    private var hourArr: Array<Int> = []
    private var minuteArr: Array<Int> = []
    private var secondArr: Array<Int> = []
    
    // MARK: 记录日期选择位置的下标(默认为第0个)
    private var yearIndex = 0
    private var monthIndex = 0
    private var dayIndex = 0
    private var hourIndex = 0
    private var minuteIndex = 0
    private var secondIndex = 0
    
    // MARK: 最终选中的时间结果
    private var selectDateString = ""
    
    // MARK: 视图控件
    private var datePickerView = UIPickerView()
    private var cancelBtn = UIButton(type: .custom)
    private var ensureBtn = UIButton(type: .custom)
    private var alphaView = UIView()
    
    /// 私有时间选择器风格(默认为年)
    private var _style: HTDatePickerStyle = .Y
    var delegate: HTDatePickerDelegate?
    
    
    
    private func creatView(){
        self.backgroundColor = UIColor.clear
        alphaView.frame = CGRect(x: 0, y: 0, width: screen_w, height: self.frame.size.height - 300)
        alphaView.alpha = 0
        alphaView.isUserInteractionEnabled = true
        alphaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideDatePicker)))
        alphaView.backgroundColor = UIColor.black
        
        cancelBtn.frame = CGRect(x: 20, y: alphaView.frame.size.height + alphaView.frame.origin.y + 5, width: self.frame.width / 5, height: 30)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.tag = 666
        cancelBtn.setTitleColor(UIColor.gray, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelBtn.addTarget(self, action: #selector(clickBtn(sender:)), for: .touchUpInside)
        self.addSubview(cancelBtn)
        
        ensureBtn.frame = CGRect(x: self.frame.size.width * 4 / 5 - 20, y: cancelBtn.frame.origin.y, width: self.frame.width / 5, height: 30)
        ensureBtn.setTitle("确定", for: .normal)
        ensureBtn.tag = 777
        ensureBtn.setTitleColor(UIColor.gray, for: .normal)
        ensureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        ensureBtn.addTarget(self, action: #selector(clickBtn(sender:)), for: .touchUpInside)
        self.addSubview(ensureBtn)
        
        datePickerView = UIPickerView(frame: CGRect(x: 0, y: cancelBtn.frame.origin.y + cancelBtn.frame.size.height + 14, width: self.frame.size.width, height: 300))
        datePickerView.delegate = self
        datePickerView.dataSource = self
        datePickerView.layer.borderWidth = 1.5
        datePickerView.layer.borderColor = UIColor(red: 232.0 / 255.0, green: 232.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0).cgColor
        self.addSubview(datePickerView)
    }
    
    /// 加载数据
    fileprivate func configData(){
        for i in 0...23 {
            hourArr.append(i)
            if i > 0 && i <= 12 {
                monthArr.append(i)
            }
        }
        for i in 0..<60 {
            minuteArr.append(i)
            secondArr.append(i)
        }
        for i in min_year...max_year {
            yearArr.append(i)
        }
    }
    
    /// 计算每个月的天数
    ///
    /// - Parameters:
    ///   - year: 年份
    ///   - month: 月份
    fileprivate func daysForm(year: Int, month: Int){
        dayArr.removeAll()
        let isLeapYear = year % 4 == 0 ? (year % 100 == 0 ? (year % 400 == 0 ? true : false) : true) : false
        
        switch month {
        case 1,3,5,7,8,10,12:
            for i in 1...31{
                dayArr.append(i)
            }
        case 4,6,9,11:
            for i in 1...30{
                dayArr.append(i)
            }
        case 2:
            if isLeapYear {
                for i in 1...29{
                    dayArr.append(i)
                }
            }else{
                for i in 1...28{
                    dayArr.append(i)
                }
            }
        default:
            break
        }
    }
    
    /// 滚动到当前时间
    fileprivate func scrollToCurrentDate(){
        
        let date = Date()
        
        daysForm(year: date.year(), month: date.month())
        
        yearIndex = date.year() - min_year
        monthIndex = date.month() - 1
        dayIndex = date.day() - 1
        hourIndex = date.hour()
        minuteIndex = date.minute()
        secondIndex = date.second()
        
        
        
        var indexArr: Array<Int> = []
        switch _style {
        case .Y:
            indexArr = [yearIndex]
            selectDateString = "\(yearArr[yearIndex])"
        case .YM:
            indexArr = [yearIndex, monthIndex]
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d", monthArr[monthIndex])
        case .YMD:
            indexArr = [yearIndex, monthIndex, dayIndex]
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d-%02d", monthArr[monthIndex], dayArr[dayIndex])
        case .YMDH:
            indexArr = [yearIndex, monthIndex, dayIndex, hourIndex]
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d-%02d %02d", monthArr[monthIndex], dayArr[dayIndex], hourArr[hourIndex])
        case .YMDHM:
            indexArr = [yearIndex, monthIndex, dayIndex, hourIndex, minuteIndex]
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d-%02d %02d:%02d", monthArr[monthIndex], dayArr[dayIndex], hourArr[hourIndex], minuteArr[minuteIndex])
        default:
            indexArr = [yearIndex, monthIndex, dayIndex, hourIndex, minuteIndex, secondIndex]
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d-%02d %02d:%02d:%02d", monthArr[monthIndex], dayArr[dayIndex], hourArr[hourIndex], minuteArr[minuteIndex], secondArr[secondIndex])
        }
        datePickerView.reloadAllComponents()
        for i in 0..<indexArr.count {
            datePickerView.selectRow(indexArr[i], inComponent: i, animated: true)
        }
    }
    
    /// 根据年月日时分秒判断是否早于当前时间
    ///
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    ///   - hour: 时
    ///   - minute: 分
    ///   - second: 秒
    /// - Returns: 是否早于当前时间
    fileprivate func isEarlyThanCurrentTimeWith(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Bool{
        let date = Date()
        if year > date.year() {
            return false;
        }else if year == date.year(){
            
            if month > date.month() {
                return false
            }else if month == date.month() {
                
                if day > date.day() {
                    return false
                }else if day == date.day() {
                    
                    if hour > date.hour() {
                        return false
                    }else if hour == date.hour() {
                        
                        if minute > date.minute() {
                            return false
                        }else if minute == date.minute() {
                            
                            if second >= date.second() {
                                return false
                            }else{
                                return true
                            }
                            
                        }else{
                            return true
                        }
                        
                    }else{
                        return true
                    }
                    
                }else{
                    return true
                }
                
            }else{
                return true
            }
            
        }else{
            return true
        }
    }
    
    // MARK: 按钮点击方法
    @objc func clickBtn(sender: UIButton){
        if sender.tag == 666 {
            hideDatePicker()
        }else{
            delegate?.clickEnsure(selectDate: selectDateString)
        }
    }
    
    
    
}
// MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension HTDatePickerSwift: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch _style {
        case .Y:
            return 1
        case .YM:
            return 2
        case .YMD:
            return 3
        case .YMDH:
            return 4
        case .YMDHM:
            return 5
        default:
            return 6
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return yearArr.count
        case 1:
            return monthArr.count
        case 2:
            return dayArr.count
        case 3:
            return hourArr.count
        case 4:
            return minuteArr.count
        default:
            return secondArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44.0
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch _style {
        case .Y:
            return self.frame.size.width / 2
        case .YM:
            return self.frame.size.width / 3
        case .YMD:
            return self.frame.size.width / 4
        case .YMDH:
            return self.frame.size.width / 5
        case .YMDHM:
            return self.frame.size.width / 6
        default:
            return self.frame.size.width / 7
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as? UILabel
        if label == nil {
            label = UILabel()
            label?.textAlignment = .center
            label?.font = UIFont.systemFont(ofSize: 15)
        }
        var title = ""
        switch component {
        case 0:
            title = "\(yearArr[row])年"
        case 1:
            title = "\(monthArr[row])月"
        case 2:
            title = "\(dayArr[row])日"
        case 3:
            title = "\(hourArr[row])时"
        case 4:
            title = "\(minuteArr[row])分"
        default:
            title = "\(secondArr[row])秒"
        }
        label?.text = title
        label?.textColor = UIColor.black
        return label!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isCanSelectBefore {     //可以选择当前时间之前的时间
            switch component {
            case 0:
                yearIndex = row
            case 1:
                monthIndex = row
            case 2:
                dayIndex = row
            case 3:
                hourIndex = row
            case 4:
                minuteIndex = row
            default:
                secondIndex = row
            }
        }else{
            switch component {
            case 0:
                if isEarlyThanCurrentTimeWith(year: yearArr[row], month: monthArr[monthIndex], day: dayArr[dayIndex], hour: hourArr[hourIndex], minute: minuteArr[minuteIndex], second: secondArr[secondIndex]){
                    scrollToCurrentDate()
                    return
                }
                yearIndex = row
            case 1:
                if isEarlyThanCurrentTimeWith(year: yearArr[yearIndex], month: monthArr[row], day: dayArr[dayIndex], hour: hourArr[hourIndex], minute: minuteArr[minuteIndex], second: secondArr[secondIndex]){
                    scrollToCurrentDate()
                    return
                }
                monthIndex = row
            case 2:
                if isEarlyThanCurrentTimeWith(year: yearArr[yearIndex], month: monthArr[monthIndex], day: dayArr[row], hour: hourArr[hourIndex], minute: minuteArr[minuteIndex], second: secondArr[secondIndex]){
                    scrollToCurrentDate()
                    return
                }
                dayIndex = row
            case 3:
                if isEarlyThanCurrentTimeWith(year: yearArr[yearIndex], month: monthArr[monthIndex], day: dayArr[dayIndex], hour: hourArr[row], minute: minuteArr[minuteIndex], second: secondArr[secondIndex]){
                    scrollToCurrentDate()
                    return
                }
                hourIndex = row
            case 4:
                if isEarlyThanCurrentTimeWith(year: yearArr[yearIndex], month: monthArr[monthIndex], day: dayArr[dayIndex], hour: hourArr[hourIndex], minute: minuteArr[row], second: secondArr[secondIndex]){
                    scrollToCurrentDate()
                    return
                }
                minuteIndex = row
            default:
                if isEarlyThanCurrentTimeWith(year: yearArr[yearIndex], month: monthArr[monthIndex], day: dayArr[dayIndex], hour: hourArr[hourIndex], minute: minuteArr[minuteIndex], second: secondArr[row]){
                    scrollToCurrentDate()
                    return
                }
                secondIndex = row
            }
        }
        if component == 0 || component == 1 {
            if _style == .YMD || _style == .YMDH || _style == .YMDHM || _style == .YMDHMS {
                daysForm(year: yearArr[yearIndex], month: monthArr[monthIndex])
                datePickerView.reloadComponent(2)
                // 解决当选中的月份天数少于前一个选中月份天数时崩溃的问题
                if (dayArr.count - 1 < dayIndex) {
                    dayIndex = dayArr.count-1
                }
            }
        }
//        pickerView.reloadAllComponents()
        
        switch _style {
        case .Y:
            selectDateString = "\(yearArr[yearIndex])"
        case .YM:
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d", monthArr[monthIndex])
        case .YMD:
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d-%02d", monthArr[monthIndex], dayArr[dayIndex])
        case .YMDH:
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d-%02d %02d", monthArr[monthIndex], dayArr[dayIndex], hourArr[hourIndex])
        case .YMDHM:
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d-%02d %02d:%02d", monthArr[monthIndex], dayArr[dayIndex], hourArr[hourIndex], minuteArr[minuteIndex])
        default:
            selectDateString = String(format: "\(yearArr[yearIndex])-%02d-%02d %02d:%02d:%02d", monthArr[monthIndex], dayArr[dayIndex], hourArr[hourIndex], minuteArr[minuteIndex], secondArr[secondIndex])
        }
        
    }
}

// MARK: 公开给外部自定义样式的接口
extension HTDatePickerSwift{
    
    /// 设置取消按钮的title和字体颜色(默认为"取消" 灰色字体)
    ///
    /// - Parameters:
    ///   - title: title
    ///   - color: 字体颜色
    func setCancel(title: String, titleColor color: UIColor){
        cancelBtn.setTitle(title, for: .normal)
        cancelBtn.setTitleColor(color, for: .normal)
    }
    
    /// 设置确定按钮的title和字体颜色(默认为"确定" 蓝色字体)
    ///
    /// - Parameters:
    ///   - title: title
    ///   - color: 字体颜色
    func setEnsure(title: String, titleColor color: UIColor){
        ensureBtn.setTitle(title, for: .normal)
        ensureBtn.setTitleColor(color, for: .normal)
    }
    
    /// 展示时间选择器
    func showDatePicker(){
        scrollToCurrentDate()
        UIView.animate(withDuration: 0.35, animations: {
            self.frame = CGRect(x: 0, y: 0, width: screen_w, height: self.frame.size.height)
        }) { (finished) in
            if finished {
                self.addSubview(self.alphaView)
                self.alphaView.alpha = 0.4
            }
        }
    }
    
    /// 隐藏时间选择器
    @objc func hideDatePicker(){
        UIView.animate(withDuration: 0.35, animations: {
            self.alphaView.alpha = 0
            self.frame = CGRect(x: 0, y: screen_h, width: screen_w, height: self.frame.size.height)
        }) { (finished) in
            if finished {
                self.alphaView.removeFromSuperview()
            }
        }
    }
}

// MARK: Date的Extension
extension Date{
    /// 年
    func year() -> Int{
        let component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.year!
    }
    /// 月
    func month() -> Int{
        let component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.month!
    }
    /// 日
    func day() -> Int{
        let component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.day!
    }
    /// 时
    func hour() -> Int{
        let component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.hour!
    }
    /// 分
    func minute() -> Int{
        let component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.minute!
    }
    /// 秒
    func second() -> Int{
        let component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return component.second!
    }
    
}


