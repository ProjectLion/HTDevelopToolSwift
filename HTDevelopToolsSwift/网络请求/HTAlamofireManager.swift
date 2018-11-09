//
//  HTAlamofireManager.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/11/9.
//  Copyright © 2018 HT. All rights reserved.
//

import UIKit
import Alamofire

/*
 Alamofire的提示不友好，所以粗糙的封装了一层。使用类方法实现可以防止闭包循环引用造成的cresh
 */


/// 网络请求管理类 (可以基于具体项目请求数据再进行封装)
class HTAlamofireManager: NSObject {
    
    /// 默认 (get请求)
    ///
    /// - Parameters:
    ///   - url: 请求地址(可以是string，可以是URL格式)
    ///   - success: 请求成功的回调
    ///   - failure: 请求失败的回调
    class func defaultRequest(url: URLConvertible, success: @escaping (_ data: Any?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        Alamofire.request(url).responseJSON { (response) in
            response.result.ifSuccess {
                success(response.result.value)
                }.ifFailure {
                    failure(response.result.error)
            }
        }
    }
    /// post请求
    ///
    /// - Parameters:
    ///   - url: 请求地址(可以是string，可以是URL格式)
    ///   - parameters: 参数
    ///   - encoding: 编码格式，默认JSONEncoding.default
    ///   - header: 请求头
    ///   - success: 请求成功的回调
    ///   - failure: 请求失败的回调
    class func post(url: URLConvertible, parameters: Parameters?, encoding: ParameterEncoding = JSONEncoding.default, header: HTTPHeaders?, success: @escaping (_ data: Any?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: encoding, headers: header).responseJSON { (response) in
            response.result.ifSuccess {
                success(response.result.value)
                }.ifFailure {
                    failure(response.result.error)
            }
        }
    }
    
    /// get请求
    ///
    /// - Parameters:
    ///   - url: 请求地址(可以是string，可以是URL格式)
    ///   - parameters: 参数
    ///   - encoding: 编码格式
    ///   - header: 请求头
    ///   - success: 请求成功的回调
    ///   - failure: 请求失败的回调
    class func get(url: URLConvertible, parameters: Parameters?, encoding: ParameterEncoding = JSONEncoding.default, header: HTTPHeaders?, success: @escaping (_ data: Any?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        Alamofire.request(url, method: .get, parameters: parameters, encoding: encoding, headers: header).responseJSON { (response) in
            response.result.ifSuccess {
                success(response.result.value)
                }.ifFailure {
                    failure(response.result.error)
            }
        }
    }
}
