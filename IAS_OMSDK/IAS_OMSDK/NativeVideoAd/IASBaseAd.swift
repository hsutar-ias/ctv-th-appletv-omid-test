//
//  IASBaseAd.swift
//  IAS_OMSDK
//
//  Created by Archana Deshmukh on 25/09/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation
import AVKit
import UIKit
import CoreGraphics
import TVUIKit
public class IASBaseAd: UIViewController {
    var adType: String = ""
    var info: IASNativeVideoAdInfo!
    var periodicTimeObserver: Any?
    var avPlayerVC : AVPlayerViewController!
    var player : AVPlayer?
    var isPlayStarted = false
    var isPlaying = true
    var isMuted:Bool = false
    weak var currentFocusedView: UIView?
    let videoUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    
    static let nativeVideoAdsNib = "IASVideoViewController"
    static let nativeAudioAdsNib = "IASAudioViewController"

    static let audioAd = "AudioAd"
    static let videoAd = "VideoAd"
    
    func playerSetup(url : URL, nativeVideoView: IASNativeVideoView) {
        // static URL if the Vast response Video URl string is null
        // DispatchOnce.clearTokens()
        avPlayerVC = AVPlayerViewController()
        player = AVPlayer(url: url)
        avPlayerVC.player = player
        addChild(avPlayerVC)
        nativeVideoView.addSubview(avPlayerVC.view)
            
        avPlayerVC.view.frame = nativeVideoView.frame//or use autolayout to constran the view properly
        nativeVideoView.addSubview(avPlayerVC.view)

        avPlayerVC.didMove(toParent: self)
        avPlayerVC.player?.play()
    }
    
//    // For pause and resume and fire there events
//    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//
//        if keyPath == "rate" && (change?[NSKeyValueChangeKey.newKey] as? Float) == 0 {
//            session?.mediaPaused()
//            requestTrackingEvents(info?.adTrackingEvents?.pause)
//        } else if keyPath == "rate" && (change?[NSKeyValueChangeKey.newKey] as? Float) == 1 {
//            session?.mediaResumed()
//            requestTrackingEvents(info?.adTrackingEvents?.resume)
//        }
//
//}
    
//    public override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        currentFocusedView = context.nextFocusedView
//        super.didUpdateFocus(in: context, with: coordinator)
//
//        if adType == AppConstant.Labels.videoAd{
//            if !avPlayerVC.showsPlaybackControls {
//                    avPlayerVC.showsPlaybackControls = true
//            }
//        }
//
//    }
//
//    //Tells this object when a physical button is first pressed.
//    public override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
//        super.pressesBegan(presses, with: event)
//        guard let buttonPress = presses.first?.type else { return }
//
//        // When user press menu button or back button it will redirect them on ad config screen and fire skip  impression
//        if (buttonPress == .menu){
//            avPlayerVC.player = nil
//            session?.playerSkipped()
//            requestTrackingEvents(info?.adTrackingEvents?.skip)
//        }
//
//        // if adtype is video ad
//        if adType == AppConstant.Labels.videoAd{
//            // For up arrow press skip and mute button visibility gone
//            if (buttonPress == .upArrow) {
//                let subViewStack = view.subviews
//                subViewStack[1].isHidden = true
//            }
//            // For up arrow press skip and mute button visible
//            if (buttonPress == .downArrow) {
//                let subViewStack = view.subviews
//                subViewStack[1].isHidden = false
//                subViewStack[1].becomeFirstResponder()
//    //            skipButton.window?.becomeFirstResponder()
//                view.subviews[1].setNeedsFocusUpdate()
//            }
//        }
//
//        // if adtype is audio ad
//        else if adType == AppConstant.Labels.audioAd{
//            if (buttonPress == .leftArrow) {
//                if !String(describing: currentFocusedView).contains("_AVFocusContainerView") {
//                    setNeedsFocusUpdate()
//                }
//            }
//        }
//
//    }
//
//    // To detect a quartile and Fire event for every quartile or midpoint
//    private func onQuartileTick() {
//
//        if let player = self.player, let infoDuration = info?.duration {
//
//            // for audio ads
//            if adType == AppConstant.Labels.audioAd{
//                let currentDuration = player.currentTime()
//                let totalDuration = Double(player.currentItem?.duration.seconds ?? 0.0)
//
//                // when value change this notification center brodcast the new value and from audio ad child class you can fetch it and update it on UI
//                let progressInfo = ["value": totalDuration, "current": currentDuration, "total":totalDuration] as [String : Any]
//                NotificationCenter.default.post(name: Notification.Name("progressInfo"), object: nil, userInfo: progressInfo)
//
//            }
//
//            // To fire quartile events
//            let duration = CMTimeGetSeconds(player.currentTime())
//            if duration >= 1 {
//                requestImpression()
//            }
//            if duration > infoDuration * 0.25 {
//                DispatchOnce.once(token: "firstQuartile") {
//                    session?.firstQuartile()
//                    requestTrackingEvents(info?.adTrackingEvents?.firstQuartile)
//                }
//            }
//            if duration > infoDuration * 0.50 {
//                DispatchOnce.once(token: "midpoint") {
//                    session?.midpoint()
//                    requestTrackingEvents(info?.adTrackingEvents?.midpoint)
//                }
//            }
//            if duration > infoDuration * 0.75 {
//                DispatchOnce.once(token: "thirdQuartile") {
//                    session?.thirdQuartile()
//                    requestTrackingEvents(info?.adTrackingEvents?.thirdQuartile)
//                }
//            }
//        }
//    }
//
//
//
//    // When audio or video ad is ended
//    @objc private func onReceiveEnd(_ notification: Notification?) {
//        session?.endOfPlayingVideo()
//        requestTrackingEvents(info?.adTrackingEvents?.complete)
//    }
//
//    //When got an error to play video
//    @objc private func onReceiveErrorNotification(_ notification: Notification?) {
//        if let userInfo = notification?.userInfo {
//            print("error while playing video \(userInfo)")
//        }
//        session?.endOfPlayingVideo()
//    }
//
//    // To get a travking events of particullar ad
//    func requestTrackingEvents(_ trackingEvents: [OMIDTrackingEvent]?) {
//        if let events = trackingEvents {
//            for (_ , event) in events.enumerated() {
//                if let url = URL(string: event.trackingUrl) {
//                    loadURL(url)
//                }
//            }
//        }
//    }
//
//    // To get Impression of ad
//    private func requestImpression() {
//        DispatchOnce.once(token: "impression") {
//            guard let impressions = info.impressions else {
//                return
//            }
//            for (_ , impression) in impressions.enumerated() {
//                if let url = URL(string: impression.impressionUrl!) {
//                    loadURL(url)
//                }
//            }
//        }
//    }
//
//    // Load the URL called load data and pass the URL
//    private func loadURL(_ url: URL) {
//        IASNetworkHelper.loadData(with: url) { (data) in
//
//        } errorHandler: { (error) in
//
//        }
//    }
//}
//
//class DispatchOnce {
//    static var tokens: [String] = []
//
//    public static func once(token: String, block: () -> Void) {
//        if tokens.contains(token) {
//            return
//        }
//        tokens.append(token)
//        block()
//    }
//
//    public static func clearTokens() {
//        DispatchOnce.tokens.removeAll()
//    }
    
}
