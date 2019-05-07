//
//  HTAFManager.swift
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
    
    enum NetWorkStatuType {
        case wifi
        case wwan
        case not
    }
    
    /// 下载请求对象
    private var downRequest: DownloadRequest!
    /// 断点保存的data数据
    private var currentData: Data?
    /// 断点数据保存地址
    private var saveFilePath: DownloadRequest.Destination!
    
    /// 上传请求对象
    private var uploadRequest: UploadRequest!
    
    private var manager = NetworkReachabilityManager(host: "www.baidu.com")
    
    var netStatus: NetWorkStatuType = .not
    
    static let shared = HTAlamofireManager()
    private override init() {
        
    }
    
    /// 默认 (get请求)
    ///
    /// - Parameters:
    ///   - url: 请求地址(可以是string，可以是URL格式)
    ///   - success: 请求成功的回调
    ///   - failure: 请求失败的回调
    class func defaultRequest(url: URLConvertible, success: @escaping (_ data: Any?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                failure(error)
            } else {
                success(response.value)
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
        AF.request(url, method: .post, parameters: parameters, encoding: encoding, headers: header).responseJSON { (response) in
            if let error = response.error {
                failure(error)
            } else {
                success(response.value)
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
        AF.request(url, method: .get, parameters: parameters, encoding: encoding, headers: header).responseJSON { (response) in
            if let error = response.error {
                failure(error)
            } else {
                success(response.value)
            }
        }
    }
    
    /// 下载
    ///
    /// - Parameters:
    ///   - url: 下载地址
    ///   - progress: 进度回调
    ///   - success: 下载成功回调
    ///   - failure: 下载失败回调
    func downLoad(url: URLConvertible, toPath path: String, progress: @escaping (Progress) -> Void, success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        saveFilePath = {
            _, _ in
            return (URL(fileURLWithPath: path), [.removePreviousFile])
        }
        if let data = currentData {
            downRequest = AF.download(resumingWith: data, to: saveFilePath)
        } else {
            downRequest = AF.download(url, to: saveFilePath)
        }
        downRequest.downloadProgress(closure: progress)
        downRequest.responseData { (response) in
            if let error = response.error {
                failure(error)
            } else {
                success()
            }
        }
    }
    
    /// 上传
    ///
    /// - Parameters:
    ///   - filePath: 文件地址
    ///   - toUrl: 上传地址
    ///   - progress: 进度回调
    ///   - success: 成功回调
    ///   - failure: 失败回调
    func upload(filePath path: String, toUrl to: URLConvertible, progress: @escaping (Progress) -> Void = { _ in }, success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        uploadRequest = AF.upload(URL(fileURLWithPath: path), to: to)
        uploadRequest.uploadProgress(closure: progress)
        uploadRequest.responseData(completionHandler: { (response) in
            if let error = response.error {
                failure(error)
            } else {
                success()
            }
        })
    }
    
    
    func upload(fileData data: Data, toUrl to: URLConvertible, progress: @escaping (Progress) -> Void = { _ in }, success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        uploadRequest = AF.upload(data, to: to)
        uploadRequest.uploadProgress(closure: progress)
        uploadRequest.responseData(completionHandler: { (response) in
            if let error = response.error {
                failure(error)
            } else {
                success()
            }
        })
    }
    
}
