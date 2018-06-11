//
//  HTShareManager.swift
//  MagicSwift
//
//  Created by Ht on 2018/5/23.
//  Copyright © 2018年 secher. All rights reserved.
//

import UIKit
//import Alamofire

///*****      分享相关的一些固定数据      ******/
///// 分享视频时的标题
//fileprivate let ShareVideoTitle = "看看我用Magi AR拍的视频吧"
///// 分享视频时的内容
//fileprivate let ShareVideoContent = "拍点不一样的AR短视频"
///// 分享App时的标题
//fileprivate let ShareAppTitle = "快来使用Magi吧"
///// 分享App时的内容
//fileprivate let ShareAppContent = "快来使用Magi吧"
///// 分享到微信选择原生分享时的alertContent
//fileprivate let ShareToWXAlertContent = "微信6.5.1以上版本可用，请打开微信后从相册选择视频分享到朋友圈"
///// 分享到QQ好友选择原生分享时的alertContent
//fileprivate let ShareToQQAlertContent = "请打开QQ后从相册选择视频发送给好友"
///// 分享到QQ空间选择原生分享时的alertContent
//fileprivate let ShareToQQZoneAlertContent = "请打开QQ后从手机选择视频发表说说"
///// 分享Magi链接时的title
//fileprivate let ShareWebLinkTitle = "快来下载Magi AR增强现实相机"
///// 分享Magi链接时的content
//fileprivate let ShareWebLinkContent = "拍点不一样的AR短视频!"
///// 没有微博客户端
//fileprivate let DontHaveWeiboApp = "您没有安装微博客户端!"
///// 没有微信客户端
//fileprivate let DontHaveWXApp = "您没有安装微信客户端!"
///// 没有QQ客户端
//fileprivate let DontHaveQQApp = "您没有安装QQ客户端!"
///// 分享图片到微博时的content
//fileprivate let SharePhotoToWeiboContent = "#Magi-AR# @Magi-AR 看看我用Magi AR制作的图片，一起来拍点不一样的AR短视频吧！猛戳查看>>"
///// 分享视频到微博时的content
//fileprivate let ShareVideoToWeiboContent = "#Magi-AR# @Magi-AR 看看我用Magi AR制作的短视频，一起来拍点不一样的AR短视频吧！猛戳查看>>"
///// 分享Magi到微博时的content
//fileprivate let ShareMagiToWeiboContent = "#Magi-AR# @Magi-AR 快来下载Magi AR，一起来拍点不一样的AR短视频吧 ！猛戳查看>>"
///**************************/
//
//
//enum HTShareType: String {
//    case Wetchat = "微信好友"
//    case Wetchat_pyq = "朋友圈"
//    case QQ = "qq好友"
//    case QQ_zone = "qq空间"
//    case Weibo = "微博"
//    case Weibo_stordy = "微博故事"
//}
//
//enum HTShareDataType {
//    case video
//    case photo
//    case webLink
//}
//
///// 统一管理集成的原生分享
//class HTShareManager: NSObject {
//
//    static let shared = HTShareManager()
//    private override init() {
//
//    }
//
//    /// 分享到第三方平台
//    ///
//    /// - Parameters:
//    ///   - type: 平台类型
//    ///   - dataType: 分享的数据类型
//    ///   - path: 文件路径(图片类型为本地路径, 视频类型为上传到七牛后的地址, 网页类型为Magi的下载地址)
//    ///   - thumbImg: 缩略图(图片类型为被分享的图片的截图, 视频类型为本地视频文件的缩略图, 网页类型为App图标)
//    func shareTo(toType type: HTShareType, dataType: HTShareDataType, url: String, thumbImg: UIImage) {
//        switch dataType {
//        case .video:
//            // 先上传到七牛
//            shareVideoTo(toType: type, url: url, thumbImg: thumbImg)
//        case .photo:
//            sharePhotoTo(toType: type, filePath: url, thumbImg: thumbImg)
//        case .webLink:
//            shareWebLinkTo(toType: type, url: url, thumbImg: thumbImg)
//        }
//    }
//
//}
//
////MARK: ^^^^^^^^^^^^^^^ 按照分享的数据类型区分 ^^^^^^^^^^^^^^^
//extension HTShareManager {
//    /// 分享图片到第三方App
//    ///
//    /// - Parameters:
//    ///   - type: 平台类型
//    ///   - path: 图片路径
//    ///   - thumbImg: 缩略图
//    private func sharePhotoTo(toType type: HTShareType, filePath path: String, thumbImg: UIImage) {
//        switch type {
//        case .Wetchat, .Wetchat_pyq:          // 微信
//            shareToWX(type: .photo, url: path, space: type, thumbImg: thumbImg)
//        case .Weibo, .Weibo_stordy:           // 微博
//            shareToWeibo(type: .photo, url: path, space: type, thumbImg: thumbImg)
//        case .QQ, .QQ_zone:                   // QQ
//            shareToQQ(type: .photo, url: path, space: type, thumbImg: thumbImg)
//        }
//    }
//
//    /// 分享视频到第三方App
//    ///
//    /// - Parameters:
//    ///   - type: 平台类型
//    ///   - path: 视频路径
//    ///   - thumbImg: 缩略图
//    private func shareVideoTo(toType type: HTShareType, url: String, thumbImg: UIImage) {
//        switch type {
//        case .Wetchat, .Wetchat_pyq:          // 微信
//            shareToWX(type: .video, url: url, space: type, thumbImg: thumbImg)
//        case .Weibo, .Weibo_stordy:           // 微博
//            shareToWeibo(type: .video, url: url, space: type, thumbImg: thumbImg)
//        case .QQ, .QQ_zone:                   // QQ
//            shareToQQ(type: .video, url: url, space: type, thumbImg: thumbImg)
//        }
//    }
//
//    /// 分享链接到第三方App
//    ///
//    /// - Parameters:
//    ///   - type: 平台类型
//    ///   - path: 链接
//    ///   - thumbImg: 缩略图
//    private func shareWebLinkTo(toType type: HTShareType, url: String, thumbImg: UIImage) {
//        switch type {
//        case .Wetchat, .Wetchat_pyq:          // 微信
//            shareToWX(type: .webLink, url: url, space: type, thumbImg: thumbImg)
//        case .Weibo, .Weibo_stordy:           // 微博
//            shareToWeibo(type: .webLink, url: url, space: type, thumbImg: thumbImg)
//        case .QQ, .QQ_zone:                   // QQ
//            shareToQQ(type: .webLink, url: url, space: type, thumbImg: thumbImg)
//        }
//    }
//}
////MARK: ^^^^^^^^^^^^^^^ 按照平台区分 ^^^^^^^^^^^^^^^
//extension HTShareManager {
//
//    /// 分享到微信
//    ///
//    /// - Parameters:
//    ///   - type: 分享的数据类型
//    ///   - url: 文件地址
//    ///   - space: 具体的分享位置
//    ///   - thumbImg: 缩略图(只有链接和视频能设置缩略图)
//    private func shareToWX(type: HTShareDataType, url: String, space: HTShareType, thumbImg: UIImage) {
//
//        if WXApi.isWXAppInstalled() {
//            if WXApi.isWXAppSupport() {     // 判断当前的微信版本是否支持OpenApi
//                // 获取回话
//                let message = WXMediaMessage()
//                // 缩略图(微信分享图片时不能设置缩略图)
//                //        message.setThumbImage(thumbImg)
//                // 请求对象
//                let sendReq = SendMessageToWXReq()
//                // 发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
//                // 上面是官方的解释 (图片、视频、链接都属于多媒体,所以将其设为false)
//                sendReq.bText = false
//
//                /// 缩略图大小不能大于32687
//                var resultImg = thumbImg
//                // 先压缩一次
//                let imgData = UIImageJPEGRepresentation(resultImg, 0.1)
//                /// 如果大于要求的再继续压缩
//                if imgData!.count > 30000 {
//                    resultImg = MGFileManager.share.compressImage(resultImg, toByte: 30000)
//                } else {
//                    resultImg = UIImage(data: imgData!)!
//                }
//
//                switch type {
//                case .photo:
//                    let obj = WXImageObject()
//                    // 有了imageData就不用设置缩略图
//                    obj.imageData =  try! Data(contentsOf: URL(fileURLWithPath: url))
//                    message.mediaObject = obj
//                    sendReq.message = message
//                case .video:
//                    let obj = WXVideoObject()
//                    obj.videoUrl = url
////                    message.thumbData = UIImageJPEGRepresentation(, 0.1)
//
//                    message.setThumbImage(resultImg)
//                    message.mediaObject = obj
//                    message.title = ShareVideoTitle
//                    message.description = ShareVideoContent
//                    sendReq.message = message
//                case .webLink:
//                    let obj = WXWebpageObject()
//                    obj.webpageUrl = url
//                    message.setThumbImage(resultImg)
//                    message.mediaObject = obj
//                    message.title = ShareWebLinkTitle
//                    message.description = ShareWebLinkContent
//                    sendReq.message = message
//                }
//                switch space {
//                case .Wetchat:
//                    sendReq.scene = Int32(WXSceneSession.rawValue)
//                case .Wetchat_pyq:
//                    sendReq.scene = Int32(WXSceneTimeline.rawValue)
//                default:
//                    break
//                }
//                DispatchQueue.main.async {
//                    WXApi.send(sendReq)
//                }
//            } else {
//                /// showAlert
////                print("HT------>DEBUG: 判断当前的微信版本是否支持OpenApi")
//                MGMessageAlert.share.showAlert(text: "您当前的微信版本过低,请更新微信或打开微信App从手机相册选择分享")
//            }
//        } else {
//            /// showAlert
//            MGMessageAlert.share.showAlert(text: "您没有安装微信")
//        }
//    }
//
//    /// 分享到微博
//    ///
//    /// - Parameters:
//    ///   - type: 分享的数据类型
//    ///   - url: 文件地址
//    ///   - space: 具体的分享位置
//    ///   - thumbImg: 缩略图(只有链接和视频能设置缩略图)
//    private func shareToWeibo(type: HTShareDataType, url: String, space: HTShareType, thumbImg: UIImage) {
//        if WeiboSDK.isWeiboAppInstalled() {
//            let message = WBMessageObject.message() as! WBMessageObject
//            switch type {
//            case .photo:
//                // 消息的图片内容中，图片数据不能为空并且大小不能超过10M
//                let obj = WBImageObject.object() as! WBImageObject
//                obj.imageData = UIImageJPEGRepresentation(thumbImg, 1.0)
//                message.text = SharePhotoToWeiboContent + url
//                message.imageObject = obj
//            case .video:
//                message.text = ShareMagiToWeiboContent + url
//            case .webLink:
//                message.text = ShareMagiToWeiboContent + url
//                break
//            }
//            let request = WBSendMessageToWeiboRequest.request(withMessage: message) as! WBSendMessageToWeiboRequest
//            DispatchQueue.main.async {
//                WeiboSDK.send(request)
//            }
//        } else {
//            MGMessageAlert.share.showAlert(text: "您没有安装微博")
//        }
//    }
//
//    /// 分享到QQ
//    ///
//    /// - Parameters:
//    ///   - type: 分享的数据类型
//    ///   - url: 文件地址
//    ///   - space: 具体的分享位置
//    ///   - thumbImg: 缩略图(只有链接和视频能设置缩略图)
//    private func shareToQQ(type: HTShareDataType, url: String, space: HTShareType, thumbImg: UIImage) {
//        if TencentOAuth.iphoneQQInstalled() {
//            let imgData = thumbImg.ht_transformToData()
//            switch type {
//            case .photo:
//                if space == .QQ {
//                    let imgObj = QQApiImageObject(data: imgData, previewImageData: imgData, title: "", description: "")
//                    let req = SendMessageToQQReq.init(content: imgObj!)
//                    DispatchQueue.main.async {
////                        print("HT------>DEBUG: \(QQApiInterface.send(req!))")
//                    }
//                } else if space == .QQ_zone{
//
//                    let imgObj = QQApiImageArrayForQZoneObject(imageArrayData: [imgData], title: "", extMap: nil)
//                    let req = SendMessageToQQReq.init(content: imgObj!)
//                    DispatchQueue.main.async {
////                        print("HT------>DEBUG: \(QQApiInterface.sendReq(toQZone: req!))")
//                    }
//                }
//                break
//            case .video:
//                let obj = QQApiNewsObject(url: URL(string: url), title: ShareVideoTitle, description: ShareVideoContent, previewImageData: imgData, targetContentType: QQApiURLTargetTypeNews)
//                let req = SendMessageToQQReq.init(content: obj!)
//                if space == .QQ {
//                    DispatchQueue.main.async {
//                        QQApiInterface.send(req!)
//                    }
//                } else if space == .QQ_zone {
//                    DispatchQueue.main.async {
//                        QQApiInterface.sendReq(toQZone:req!)
//                    }
//                }
//            case .webLink:
//                /// 分享到QQ时分享链接类型要用  QQApiNewsObject
//                let obj = QQApiNewsObject(url: URL(string: url), title: ShareWebLinkTitle, description: ShareWebLinkContent, previewImageData: imgData, targetContentType: QQApiURLTargetTypeNews)
//                let req = SendMessageToQQReq.init(content: obj!)
//                if space == .QQ {
//                    DispatchQueue.main.async {
//                        QQApiInterface.send(req!)
//                    }
//                } else if space == .QQ_zone {
//                    DispatchQueue.main.async {
//                        QQApiInterface.sendReq(toQZone:req!)
//                    }
//                }
//
//            }
//        } else {
//            MGMessageAlert.share.showAlert(text: "您没有安装手机QQ")
//        }
//
//    }
//
//}
////MARK: ^^^^^^^^^^^^^^^ TencentSessionDelegate ^^^^^^^^^^^^^^^
//extension HTShareManager : TencentSessionDelegate {
//    func tencentDidLogin() {
//
//    }
//
//    func tencentDidNotLogin(_ cancelled: Bool) {
//
//    }
//
//    func tencentDidNotNetWork() {
//
//    }
//}
//
////MARK: ^^^^^^^^^^^^^^^ WXApiDelegate ^^^^^^^^^^^^^^^
//extension HTShareManager: WXApiDelegate {
//    func onReq(_ req: BaseReq!) {
//
//    }
//    func onResp(_ resp: BaseResp!) {
////        print("HT------>DEBUG: \(resp.errCode)====\(resp.errStr)")
//        switch resp.errCode {
//        case 0:
//            MGMessageAlert.share.showAlert(text: "分享成功")
//        case -2:
//            MGMessageAlert.share.showAlert(text: "分享已经取消")
//        default:
//            MGMessageAlert.share.showAlert(text: "分享失败")
//        }
//    }
//}
//
////MARK: ^^^^^^^^^^^^^^^ WeiboSDKDelegate ^^^^^^^^^^^^^^^
//extension HTShareManager: WeiboSDKDelegate {
//    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
//
//    }
//
//    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
//        if response.isKind(of: WBSendMessageToWeiboResponse.self) {
//            switch response.statusCode {
//            case .success:
//                MGMessageAlert.share.showAlert(text: "分享成功")
//            case .userCancel:
//                MGMessageAlert.share.showAlert(text: "分享已经取消")
//            default:
//                MGMessageAlert.share.showAlert(text: "分享失败")
//            }
//        }
//    }
//}

