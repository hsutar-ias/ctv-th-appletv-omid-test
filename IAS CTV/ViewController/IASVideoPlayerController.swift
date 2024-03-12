//
//  IASVideoPlayer.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 17/05/21.
//

import Foundation
import UIKit
import AVKit
import TVUIKit

class IASVideoPlayerController: UIViewController, AVPlayerViewControllerDelegate{
    var info: IASNativeVideoAdInfo!
    var periodicTimeObserver: Any?
    var session: AdSession?
    var avPlayerVC : AVPlayerViewController!
    var player : AVPlayer?
    var isPlayStarted = false
    var isMuted:Bool = false
    weak var currentFocusedView: UIView?
    
    @IBOutlet weak var muteSkipStackView: UIStackView!
    @IBOutlet weak var muteButton: TVCaptionButtonView!
    
//    override func viewWillAppear(_ animated: Bool) {
//        <#code#>
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: info?.videoUrl ?? "") else {
            return
        }
        DispatchOnce.clearTokens()
        avPlayerVC = AVPlayerViewController()
        player = AVPlayer(url: url)
        avPlayerVC.player = player
        avPlayerVC.delegate = self

        addChild(avPlayerVC)
        avPlayerVC.view.frame = self.view.frame//or use autolayout to constran the view properly
        view.addSubview(avPlayerVC.view)
        avPlayerVC.didMove(toParent: self)
        avPlayerVC.player?.play()

        periodicTimeObserver = avPlayerVC.player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 10, timescale: 1000), queue: DispatchQueue.main, using: { [weak self] (time)  in
            self?.onQuartileTick()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveEnd(_:)), name: .AVPlayerItemDidPlayToEndTime, object: avPlayerVC.player?.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveErrorNotification(_:)), name: .AVPlayerItemFailedToPlayToEndTime, object: avPlayerVC.player?.currentItem)
        avPlayerVC.player?.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
        session = AdSession()
        session?.start()
        self.view.bringSubviewToFront(muteSkipStackView)
    }
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return muteSkipStackView.arrangedSubviews
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "rate" && (change?[NSKeyValueChangeKey.newKey] as? Float) == 0 {
            session?.mediaPaused()
            requestTrackingEvents(info?.adTrackingEvents?.pause)
        } else if keyPath == "rate" && (change?[NSKeyValueChangeKey.newKey] as? Float) == 1 {
            session?.mediaResumed()
            requestTrackingEvents(info?.adTrackingEvents?.resume)
        }
    }
    
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        currentFocusedView = context.nextFocusedView
        super.didUpdateFocus(in: context, with: coordinator)
        
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
        guard let buttonPress = presses.first?.type else { return }
        
        if (buttonPress == .leftArrow) {
            if !String(describing: currentFocusedView).contains("_AVFocusContainerView") {
                setNeedsFocusUpdate()
            }
        }
    }
    
    private func onQuartileTick() {
        if let player = self.player, let infoDuration = info?.duration {
            let duration = CMTimeGetSeconds(player.currentTime())
            if duration >= 1 {
                requestImpression()
            }
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
        DispatchOnce.once(token: "impression") {
            guard let impressions = info.impressions else {
                return
            }
            for (_ , impression) in impressions.enumerated() {
                if let url = URL(string: impression.impressionUrl!) {
                    loadURL(url)
                }
            }
        }
    }
    
    private func loadURL(_ url: URL) {
        IASNetworkHelper.loadData(with: url) { (data) in
            
        } errorHandler: { (error) in
            
        }
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        avPlayerVC.player = nil
        session?.playerSkipped()
        requestTrackingEvents(info?.adTrackingEvents?.skip)
        dismiss(animated: true)
    }
    
    @IBAction func mutePressed(_ sender: Any) {
        
        if let player = avPlayerVC.player {
            player.isMuted = !player.isMuted
            if player.isMuted {
                muteButton.contentText = "Unmute"
                session?.volumeChanged(volume: 0)
                requestTrackingEvents(info?.adTrackingEvents?.mute)
            } else {
                muteButton.contentText = "Mute"
                session?.volumeChanged(volume: 1)
                requestTrackingEvents(info?.adTrackingEvents?.unmute)
            }
        }
    }
}

class DispatchOnce {
    static var tokens: [String] = []
    
    public static func once(token: String, block: () -> Void) {
        if tokens.contains(token) {
            return
        }
        tokens.append(token)
        block()
    }
    
    public static func clearTokens() {
        DispatchOnce.tokens.removeAll()
    }
}
