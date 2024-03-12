//
//  IASAudioPlayerController.swift
//  IAS Apple CTV Demo
//
//  Created by mshah on 08/09/22.
//

import Foundation
import UIKit
import AVKit
import TVUIKit

class IASAudioPlayerController: UIViewController, AVPlayerViewControllerDelegate{
    var info: IASNativeVideoAdInfo!
    var periodicTimeObserver: Any?
    var session: AdSession?
    var avPlayerVC : AVPlayerViewController!
    var player : AVPlayer?
    var isPlayStarted = false
    var isPlaying = true
    weak var currentFocusedView: UIView?

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    
    
    
    @IBAction func playButton(_ sender: Any) {
        if isPlaying == true{
            avPlayerVC.player?.pause()
            isPlaying = false
            playButton.setImage(UIImage(systemName: "play.fill") , for: .normal)
        }
        else{
            avPlayerVC.player?.play()
            isPlaying = true
            playButton.setImage(UIImage(systemName: "pause.fill") , for: .normal)
        }
        
    }
    
    @IBAction func forwardButton(_ sender: Any) {
        
        if let duration  = player!.currentItem?.duration {
            let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
            let newTime = playerCurrentTime + 10
            if newTime < CMTimeGetSeconds(duration)
            {
                let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                player!.seek(to: selectedTime)
            }
            player?.pause()
            player?.play()
        }
    }
    @IBAction func rewindButton(_ sender: Any) {
        if let duration  = player!.currentItem?.duration {
            let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
            let newTime = playerCurrentTime - 10
            if newTime < CMTimeGetSeconds(duration)
            {
                let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                player!.seek(to: selectedTime)
            }
            player?.pause()
            player?.play()
        }
    }
    
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
//        avPlayerVC.view.frame = self.view.frame//or use autolayout to constran the view properly
        view.addSubview(avPlayerVC.view)
        avPlayerVC.didMove(toParent: self)
        avPlayerVC.player?.play()
        
        
        periodicTimeObserver = avPlayerVC.player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 10, timescale: 1000), queue: DispatchQueue.main, using: { [weak self] (time)  in
            self?.onQuartileTick()
        }
        
        )
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveEnd(_:)), name: .AVPlayerItemDidPlayToEndTime, object: avPlayerVC.player?.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveErrorNotification(_:)), name: .AVPlayerItemFailedToPlayToEndTime, object: avPlayerVC.player?.currentItem)
        avPlayerVC.player?.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
        session = AdSession()
        session?.start()
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
            
            let currentDuration = player.currentTime()
            let totalDuration = Double(player.currentItem?.duration.seconds ?? 0.0)

            self.updateTotalDurationLabelValue(value: totalDuration,current: currentDuration, total: totalDuration)
            self.updateDurationLabelValue(value: player.currentTime() )
         

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
  
    func updateTotalDurationLabelValue(value: Double,current: CMTime, total: Double)  {
    
        let secs = Int(value)
        let durationValue: String = NSString(format: "%02d:%02d", secs/60, secs%60) as String
        totalTime.text = durationValue
        
        let timeElapsed = CMTimeGetSeconds(current)
        let currentTimeSecs = Double(timeElapsed)
        
        let progresss = Float(currentTimeSecs / total)
        progressBar.setProgress(progresss, animated: false)
        

    }
    
    func updateDurationLabelValue(value: CMTime)  {
        let timeElapsed = CMTimeGetSeconds(value)
        let secs = Int(timeElapsed)
        let durationValue: String = NSString(format: "%02d:%02d", secs/60, secs%60) as String
        currentTime.text = durationValue
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
    
}
