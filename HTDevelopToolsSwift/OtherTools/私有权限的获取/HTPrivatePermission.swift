//
//  HTPrivatePermission.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/5/31.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit
import Photos



/// 私有权限的获取 需要在info.plist文件中配置相关的权限
class HTPrivatePermission: NSObject {

    /// 获取单例
    static let shared = HTPrivatePermission()
    private override init() {

    }
    
    public enum HTPhotoPermissionType {
        /// 已经获取到了
        case geted
        /// 没有权限 or 其他情况
        case other
    }

}
//MARK: ^^^^^^^^^^^^^^^ getPermissions ^^^^^^^^^^^^^^^
extension HTPrivatePermission {
    /// 主动获取摄像头权限 系统会主动弹出提示框
    func getVideoPermission(status: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { (statu) in
            status(statu)
        }
    }

    /// 主动获取麦克风权限 系统会主动弹出提示框
    func getAudioPermission(status: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .audio) { (statu) in
            status(statu)
        }
    }

    /// 获取相册的写状态权限 如果从未获取过会主动去获取,状态通过闭包返回 如果曾经获取过了会通过闭包返回对应的状态
    func getPhotoPermission(statuBlock: @escaping (HTPhotoPermissionType) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:   //已经获取到权限
            statuBlock(.geted)
        case .notDetermined:    //从未获取过权限
            PHPhotoLibrary.requestAuthorization({ (requestStatus) in
                if requestStatus == .authorized {
                    statuBlock(.geted)
                }else{
                    statuBlock(.other)
                }
            })
        default:
            statuBlock(.other)
        }
    }
}

//MARK: ^^^^^^^^^^^^^^^ checkPermissions ^^^^^^^^^^^^^^^
extension HTPrivatePermission {
    /// 检查当前相机、相册、麦克风权限
    ///
    /// - Returns: 是否获取全部权限
    func checkPermissions() -> Bool{
        return checkVideo() && checkPhoto() && checkAudio()
    }

    /// 检查相机权限
    ///
    /// - Returns: 是否获得权限
    func checkVideo() -> Bool{
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            return true
        default:
            return false
        }
    }

    /// 检查相册权限
    ///
    /// - Returns: 是否获得权限
    func checkPhoto() -> Bool{
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true
        default:
            return false
        }
    }

    /// 检查麦克风权限
    ///
    /// - Returns: 是否获得权限
    func checkAudio() -> Bool{
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .authorized:
            return true
        default:
            return false
        }
    }
}
