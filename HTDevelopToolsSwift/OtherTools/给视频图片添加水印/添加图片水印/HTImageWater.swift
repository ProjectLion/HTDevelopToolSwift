//
//  HTImageWater.swift
//  MagicSwift
//
//  Created by Ht on 2018/5/15.
//  Copyright © 2018年 secher. All rights reserved.
//

import UIKit
import AVKit

/// 给视频/图片添加图片水印
class HTImageWater: NSObject {
    /// 添加水印单例
    static let share = HTImageWater()
    private override init() {
    }
    /// 视频播放对象
    private var videoAsset: AVURLAsset?
    /// 视频输出流
    private var dlink: CADisplayLink?
    /// 视频文件输出流
    private var exporter: AVAssetExportSession?
    
    /// 给图片添加图片水印
    ///
    /// - Parameters:
    ///   - rect: 水印的rect位置大小
    ///   - youImage: 准备添加水印的图片
    ///   - waterImage: 水印图片
    ///   - filePath: 合成后的图片写入地址,可空
    ///   - returnValue: 合成后的图片
    func ht_AddImageWaterMarkToImage(rect: CGRect, yourImage originImg: UIImage, waterImage: UIImage, writeTo path: String?) -> UIImage? {
        /// 准备原始图片的cgImage
        let originCgImage = originImg.cgImage
        /// 背景图片的宽
        let originW = originCgImage?.width
        /// 背景图片的高
        let originH = originCgImage?.height
        
        /// 获取画板
        UIGraphicsBeginImageContext(CGSize(width: originW!, height: originH!))
        /// 重绘
        originImg.draw(in: CGRect(x: 0, y: 0, width: originW!, height: originH!))
        
        /// 水印宽
        let waterW = CGFloat(originW!) / 3
        /// 水印高
        let waterH = waterW * rect.size.height / rect.size.width
        
        waterImage.draw(in: CGRect(x: rect.origin.x, y: CGFloat(originH! - 50) - waterH, width: waterW, height: waterH))
        let returnImg = UIGraphicsGetImageFromCurrentImageContext()
        
//        let date = Date()
//        let timeTemp = Int(date.timeIntervalSince1970)
        
        UIGraphicsEndImageContext()
        guard let p = path else { return returnImg! }
        do {
            try returnImg!.pngData()?.write(to: URL(fileURLWithPath: p))
            return UIImage(contentsOfFile: p)
        } catch  {
            print("HT------>DEBUG: 写入文件失败")
            return returnImg
        }
        
    }
    
    /// 给录制好的本地视频添加图片水印
    ///
    /// - Parameters:
    ///   - rect: 水印的位置大小
    ///   - path: 本地视频的文件路径
    ///   - waterImage: 水印图片
    func ht_addImageWaterMarkToVideo(rect: CGRect, videoPath path: String, waterImage: UIImage, complete: @escaping (String) -> Void) {
        
        let opts = [AVURLAssetPreferPreciseDurationAndTimingKey: true]
        videoAsset = AVURLAsset(url: URL(fileURLWithPath: path), options: opts)     //初始化视频媒体文件
        let startTime = CMTime(seconds: 0.0, preferredTimescale: 600)    //2
        let endTime = CMTime(seconds: (videoAsset?.duration)!.getSeconds(), preferredTimescale: (videoAsset?.duration.timescale)!)
        //声音采集
        let audioAsset = AVURLAsset(url: URL(fileURLWithPath: path), options: opts)
        //2 创建AVMutableComposition实例. apple developer 里边的解释 【AVMutableComposition is a mutable subclass of AVComposition you use when you want to create a new composition from existing assets. You can add and remove tracks, and you can add, remove, and scale time ranges.】
        let mixComposition = AVMutableComposition()
        //3 视频通道  工程文件中的轨道，有音频轨、视频轨等，里面可以插入各种对应的素材
        let videoTrack = mixComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        //把视频轨道数据加入到可变轨道中 这部分可以做视频裁剪TimeRange
        do {
            try videoTrack?.insertTimeRange(CMTimeRange(start: startTime, duration: endTime), of: (videoAsset?.tracks(withMediaType: .video).first)!, at: CMTime.zero)
        } catch {
            
        }
        
        //音频通道
        let audioTrack = mixComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        //音频采集通道
        let audioAssetTrack = audioAsset.tracks(withMediaType: .audio).first!
        do {
            try audioTrack?.insertTimeRange(CMTimeRange(start: startTime, duration: endTime), of: audioAssetTrack, at: CMTime.zero)
        } catch {
            
        }
        
        //3.1 AVMutableVideoCompositionInstruction 视频轨道中的一个视频，可以缩放、旋转等
        let mainInstruction = AVMutableVideoCompositionInstruction()
        mainInstruction.timeRange = CMTimeRange(start: CMTime.zero, duration: (videoTrack?.timeRange.duration)!)
        
        // 3.2 AVMutableVideoCompositionLayerInstruction 一个视频轨道，包含了这个轨道上的所有视频素材
        let videolayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack!)
        let videoAssetTrack = videoAsset?.tracks(withMediaType: .video).first!
        //    UIImageOrientation videoAssetOrientation_  = UIImageOrientationUp;
        var isVideoAssetPortrait_  = false
        let videoTransform = videoAssetTrack?.preferredTransform
        if (videoTransform?.a == 0 && videoTransform?.b == 1.0 && videoTransform?.c == -1.0 && videoTransform?.d == 0) {
            //        videoAssetOrientation_ = UIImageOrientationRight;
            isVideoAssetPortrait_ = true
        }
        if (videoTransform?.a == 0 && videoTransform?.b == -1.0 && videoTransform?.c == 1.0 && videoTransform?.d == 0) {
            //        videoAssetOrientation_ =  UIImageOrientationLeft;
            isVideoAssetPortrait_ = true
        }
        //    if (videoTransform.a == 1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == 1.0) {
        //        videoAssetOrientation_ =  UIImageOrientationUp;
        //    }
        //    if (videoTransform.a == -1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == -1.0) {
        //        videoAssetOrientation_ = UIImageOrientationDown;
        //    }
        videolayerInstruction.setTransform((videoAssetTrack?.preferredTransform)!, at: CMTime.zero)
        videolayerInstruction.setOpacity(0.0, at: endTime)
        // 3.3 - Add instructions
        mainInstruction.layerInstructions = [videolayerInstruction]
        //AVMutableVideoComposition：管理所有视频轨道，可以决定最终视频的尺寸，裁剪需要在这里进行
        let mainCompositionInst = AVMutableVideoComposition()
        
        var naturalSize = CGSize.zero
        if(isVideoAssetPortrait_){
            naturalSize = CGSize(width: (videoAssetTrack?.naturalSize.height)!, height: (videoAssetTrack?.naturalSize.width)!)
        } else {
            naturalSize = (videoAssetTrack?.naturalSize)!
        }
        
        var renderWidth: CGFloat = 0, renderHeight: CGFloat = 0
        renderWidth = naturalSize.width
        renderHeight = naturalSize.height
        mainCompositionInst.renderSize = CGSize(width: renderWidth, height: renderHeight)
        mainCompositionInst.instructions = [mainInstruction]
        mainCompositionInst.frameDuration = CMTime(value: 1, timescale: 25)
        
        applyVideoEffectTo(composition: mainCompositionInst, waterImg: waterImage, size: CGSize(width: renderWidth, height: renderHeight))
        
        // 后续视频输出
        dlink = CADisplayLink(target: self, selector: #selector(displayLinkAction))
        //    [dlink setFrameInterval:15];
        dlink?.preferredFramesPerSecond = 10
        dlink?.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
        dlink?.isPaused = false
        // 5 - 视频文件输出
        
        exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
        exporter?.outputURL = URL(fileURLWithPath: path)
        exporter?.outputFileType = AVFileType.mp4
        exporter?.shouldOptimizeForNetworkUse = true
        exporter?.videoComposition = mainCompositionInst
        
        exporter?.exportAsynchronously(completionHandler: {
//            print("HT------>DEBUG: 视频导出状态++++++++++++====\(self.exporter?.status)")
            DispatchQueue.main.async {
                complete(path)
            }
        })
        
    }
    
    @objc private func displayLinkAction() {
//        print("HT------>DEBUG: progress: ====== \(exporter?.progress)")
        if ((exporter?.progress)! >= 1.0) {
//            print("HT------>DEBUG: 文件输出完成1111111")
        }
    }
    
    private func applyVideoEffectTo(composition: AVMutableVideoComposition, waterImg: UIImage, size: CGSize) {
        // 水印layer
        let overlayLayer = CALayer()
        overlayLayer.contents = waterImg.cgImage
        overlayLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        overlayLayer.masksToBounds = true
        
        
        let videoLayer = CALayer()
        let parentLayer = CALayer()
        parentLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        videoLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        videoLayer.addSublayer(<#T##layer: CALayer##CALayer#>)
        parentLayer.addSublayer(videoLayer)
        parentLayer.addSublayer(overlayLayer)
        
        composition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)
        
    }
    
}












