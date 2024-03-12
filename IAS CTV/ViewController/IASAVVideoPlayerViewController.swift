//
//  IASAVVideoPlayerViewController.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 17/05/21.
//

import Foundation
import AVKit
import UIKit

class IASAVVideoPlayerViewController: AVPlayerViewController {
    var info: IASNativeVideoAdInfo!
    var periodicTimeObserver: Any?
    var session: AdSession?
    var isPlayStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: info?.videoUrl ?? "") else {
            return
        }
        DispatchOnce.clearTokens()
        let player = AVPlayer(url: url)
        self.player = player
        periodicTimeObserver = self.player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 10, timescale: 1000), queue: DispatchQueue.main, using: { [weak self] (time)  in
            self?.onQuartileTick()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveEnd(_:)), name: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveErrorNotification(_:)), name: .AVPlayerItemFailedToPlayToEndTime, object: self.player?.currentItem)
        session = AdSession()
        self.player?.play()
        requestTrackingEvents(info?.adTrackingEvents?.start)
        session?.start()
        self.player?.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as AnyObject? === self.player {
            if keyPath == "timeControlStatus" {
                if #available(iOS 10.0, *) {
                    if self.player?.timeControlStatus == .playing {
                        session?.mediaPlay()
                        if !isPlayStarted {
                            isPlayStarted = true
                            requestImpression()
                        }
                    } else if self.player?.timeControlStatus == .paused {
                        session?.mediaPaused()
                    }
                }
            }
        }
    }
    
    private func onQuartileTick() {
        if let player = self.player, let infoDuration = info?.duration {
            let duration = CMTimeGetSeconds(player.currentTime())
            if duration > infoDuration * 0.25 {
                DispatchOnce.once(token: "firstQuartile") {
                    session?.firstQuartile()
                    requestTrackingEvents(info?.adTrackingEvents?.firstQuartile)
                }
            }
            if duration > infoDuration * 0.50 {
                DispatchOnce.once(token: "midpoint") {
                    session?.midpoint()
                    requestTrackingEvents(info?.adTrackingEvents?.midpoint)
                }
            }
            if duration > infoDuration * 0.75 {
                DispatchOnce.once(token: "thirdQuartile") {
                    session?.thirdQuartile()
                    requestTrackingEvents(info?.adTrackingEvents?.thirdQuartile)
                }
            }
        }
    }
    
    @objc private func onReceiveEnd(_ notification: Notification?) {
        session?.endOfPlayingVideo()
        requestTrackingEvents(info?.adTrackingEvents?.complete)
    }
    
    @objc private func onReceiveErrorNotification(_ notification: Notification?) {
        if let userInfo = notification?.userInfo {
            print("error while playing video \(userInfo)")
        }
        session?.endOfPlayingVideo()
    }
    
    private func requestTrackingEvents(_ trackingEvents: [OMIDTrackingEvent]?) {
        if let events = trackingEvents {
            for (_ , event) in events.enumerated() {
                if let url = URL(string: event.trackingUrl) {
                    loadURL(url)
                }
            }
        }
    }
    
    private func requestImpression() {
        guard let impressions = info.impressions else {
            return
        }
        for (_ , impression) in impressions.enumerated() {
            if let url = URL(string: impression.impressionUrl!) {
                loadURL(url)
            }
        }
    }
    
    private func loadURL(_ url: URL) {
        IASNetworkHelper.loadData(with: url) { (data) in
            
        } errorHandler: { (error) in
            
        }

    }
}

