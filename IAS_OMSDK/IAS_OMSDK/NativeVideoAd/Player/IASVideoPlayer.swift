//
//  IASVideoPlayer.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//
import Foundation
import AVFoundation
import AVKit
import TVUIKit
/**
 - Define a Enum for video player mode
 */
enum IASVideoPlayerMode : Int {
    case iasVideoBanner
}

/**
 - Define a enum for setting player state
 */
enum IASPlayerState : Int {
    case kPlayerIdle
    case kPlayerPlaying
    case kPlayerPaused
    case kPlayerStopped
    case kPlayerInactive
}

/**
 - Define a IASVideoPlayerDelegate protocol for handling a video player state
 */
protocol IASVideoPlayerDelegate: NSObjectProtocol {
    func playerPrepared(_ player: IASVideoPlayer?)
    func playerStarted(_ player: IASVideoPlayer?)
    func playerStopped(_ player: IASVideoPlayer?)
    func playerError(_ player: IASVideoPlayer?)
    var presentingViewController: UIViewController { get }
}

let TRACKS_KEY = "tracks"
let PLAYABLE_KEY = "playable"
/**
- IASVideoPlayer class extends IASVideoDelegate and implements it's functions
- This class is used for handling a video player functions
*/
class IASVideoPlayer: NSObject, IASVideoDelegate, AVPlayerViewControllerDelegate {
    
    weak var delegate: IASVideoPlayerDelegate?
    weak var sdkAdSession: SdkAdSession?
    var info: IASNativeVideoAdInfo?
    var omidImpressions: [OMIDImpression]?
    private var mode: IASVideoPlayerMode?
    private var nativeVideoView: IASNativeVideoView?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var currentTime: CMTime!
    private var quartileObserver: Any?
    private var state: IASPlayerState?
    private var asset: AVURLAsset?
    private var pendingAsset: AVURLAsset?
    private weak var videoViewInterface: IASVideoViewInterface?
    private var dispatchOnceForQurtileEvents: DispatchOnceForQurtileEvents!
    var avPlayerVC : AVPlayerViewController!
    var periodicTimeObserver : Any?
    
    init?(mode: IASVideoPlayerMode) {
        super.init()
        self.mode = mode
        switch mode {
        case .iasVideoBanner:
            nativeVideoView = IASNativeVideoView.loadFromNib()
            videoViewInterface = nativeVideoView
            break
        }
        dispatchOnceForQurtileEvents = DispatchOnceForQurtileEvents()
        videoViewInterface!.delegate = self
        videoViewInterface?.setControlsVisibility(false)
        state = .kPlayerIdle
    }
    
    func bannerView() -> UIView? {
        return nativeVideoView
    }

    func play() {
        var asset: AVURLAsset? = nil
        if let info = info {
            if let videoUrl = info.videoUrl{
                if let url = URL(string: videoUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) {
                    asset = AVURLAsset(url: url, options: nil)
                    playerSetup(url: url,nativeVideoView: nativeVideoView!)
                }
            }
        }
        if !(asset != nil) {
            onVideoPreparingError("video asset is empty")
            return
        }
        self.addVolumeListener()
        weak var weakSelf = self
        asset?.loadValuesAsynchronously(forKeys: [TRACKS_KEY, PLAYABLE_KEY]) {
            DispatchQueue.main.async(execute: {
                weakSelf?.onAssetLoaded(asset)
            })
        }
    }
    
    func playerSetup(url : URL, nativeVideoView: IASNativeVideoView) {
        avPlayerVC = AVPlayerViewController()
        player = AVPlayer(url: url)
        avPlayerVC.player = player
        avPlayerVC.delegate = self
        
//        addChild(avPlayerVC)
//        nativeVideoView.addSubview(avPlayerVC.view)
    
//        avPlayerVC.view.frame = nativeVideoView.videoView!.frame //or use autolayout to constran the view properly
//        avPlayerVC.view.frame = self.view.frame
        
//        nativeVideoView.videoView!.addSubview(nibView)
        
//        avPlayerVC.didMove(toParent: nativeVideoView.videoView.self)
        avPlayerVC.player?.play()
    
        // For measure time continuosuly for update progressbar and time text and also for fire Quartile Impression
        periodicTimeObserver = avPlayerVC.player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 10, timescale: 1000), queue: DispatchQueue.main, using: { [weak self] (time)  in
                self?.onQuartileTick()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveEndNotification(_:)), name: .AVPlayerItemDidPlayToEndTime, object: avPlayerVC.player?.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveErrorNotification(_:)), name: .AVPlayerItemFailedToPlayToEndTime, object: avPlayerVC.player?.currentItem)
        avPlayerVC.player?.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
        sdkAdSession!.start()
    }
    func skip() {
        if (player != nil) {
            player!.pause()
            sdkAdSession!.playerSkipped()
        }
        self.cleanup()
        self.delegate!.playerStopped(self)
    }
    
    func fullscreenVideoDrag(){
        if (player != nil) {
            player!.pause()
            sdkAdSession!.playerPause()
        }
        self.cleanup()
        self.delegate!.playerStopped(self)
    }
    func resume() {
        switch state {
        case .kPlayerPaused:
            self.resumePlayer()
        default:
            break
        }
    }
    
    func pause() {
        switch state {
        case .kPlayerIdle:
            state = .kPlayerPaused
        case .kPlayerPlaying:
            state = .kPlayerPaused
            self.pauseAndFireEvent(true)
        default:
            break
        }
    }
    
    func stop() {
        if (player != nil) {
            player!.pause()
        }
        self.cleanup()
    }
    
    func resumeAndFireEvent(_ fireEvent: Bool) {
        if player != nil {
        }
        player?.seek(to: currentTime, toleranceBefore: .zero, toleranceAfter: .zero){
            finished in
            self.player!.play()
            if fireEvent {
                self.sdkAdSession!.resume()
            }
        }
    }
    
    func pauseAndFireEvent(_ fireEvent: Bool) {
        player?.pause()
        currentTime = player?.currentTime()
        if fireEvent {
            sdkAdSession!.playerPause()
        }
    }
    
    func resumePlayer() {
        if (asset != nil) {
            state = .kPlayerPlaying
            resumeAndFireEvent(true)
        } else {
            state = .kPlayerIdle
            playPendingAsset()
        }
    }
    
    
    func onAssetLoaded(_ asset: AVURLAsset?) {
        if !(asset?.isPlayable ?? false) {
            onVideoPreparingError("video asset is not playable")
            return
        }
        let status = asset?.statusOfValue(forKey: TRACKS_KEY, error: nil)
        if status != .loaded {
            onVideoPreparingError("can not start player")
            return
        }
        pendingAsset = asset
        delegate!.playerPrepared(self)
        playPendingAsset()
    }
    
    func playPendingAsset() {
        if !(pendingAsset != nil) || state != .kPlayerIdle {
            return
        }
        asset = pendingAsset
        pendingAsset = nil
        playerItem = AVPlayerItem(asset: asset!)
        player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(IASVideoPlayer.onReceiveEndNotification(_:)), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        NotificationCenter.default.addObserver(self, selector: #selector(IASVideoPlayer.onReceiveErrorNotification(_:)), name: .AVPlayerItemFailedToPlayToEndTime, object: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(IASVideoPlayer.onAppWillEnterForeground), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(IASVideoPlayer.onAppDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(IASVideoPlayer.onAppWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(IASVideoPlayer.onAppDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        weak var weakSelf = self
        quartileObserver = player!.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 10, timescale: 1000), queue: DispatchQueue.main, using: { time in
            weakSelf?.onQuartileTick()
        })
        setupVideoViewInterface()
        player!.play()
        sdkAdSession!.playerStart(withDuration: CGFloat(info!.duration), volume: CGFloat(player!.volume))
        state = .kPlayerPlaying
        videoViewInterface?.setControlsVisibility(true)
        delegate!.playerStarted(self)
    }
    
    @objc func onReceiveEndNotification(_ notification: Notification?) {
        sdkAdSession!.playerComplete()
        requestTrackingEvents(info!.adTrackingEvents?.complete!)
        weak var weakSelf = self
        DispatchQueue.main.async(execute: {
            weakSelf?.onEnd()
        })
    }
    
    @objc func onReceiveErrorNotification(_ notification: Notification?) {
        print("player error \(notification?.userInfo ?? [:])")
        sdkAdSession!.error(with: OMIDErrorType.media, playerError: "Unknown player error")
        weak var weakSelf = self
        DispatchQueue.main.async(execute: {
            weakSelf?.onError()
        })
    }
    
    func onEnd() {
        cleanup()
        delegate!.playerStopped(self)
    }
    
    func onError() {
        cleanup()
        delegate!.playerError(self)
    }
    
    func onVideoPreparingError(_ errorMessage: String?) {
        delegate!.playerPrepared(self)
        cleanup()
        delegate!.playerError(self)
    }
    
    @objc func onAppWillEnterForeground() {
        
    }
    
    @objc func onAppDidEnterBackground() {
    }
    
    @objc func onAppWillResignActive() {
        switch state {
        case .kPlayerIdle:
            state = .kPlayerInactive
        case .kPlayerPlaying:
            state = .kPlayerInactive
            pauseAndFireEvent(true)
        default:
            break
        }
    }
    
    @objc func onAppDidBecomeActive() {
        switch state {
        case .kPlayerInactive:
            resumePlayer()
        default:
            break
        }
    }
    
    func cleanup() {
        NotificationCenter.default.removeObserver(self)
        if (player != nil) {
            if (quartileObserver != nil) {
                player!.removeTimeObserver(quartileObserver!)
                quartileObserver = nil
            }
        }
        sdkAdSession = nil
        playerItem = nil
        player = nil
        state = .kPlayerStopped
        asset = nil
        pendingAsset = nil
        
        videoViewInterface?.videoView?.setPlayer(nil)
        videoViewInterface?.setControlsVisibility(false)
        removeVolumeListener()
    }
    
    private func onQuartileTick() {
        if let player = self.player, let infoDuration = info?.duration {
            let duration = CMTimeGetSeconds(player.currentTime())
            if duration > infoDuration * 0.25 {
                dispatchOnceForQurtileEvents.once(token: "firstQuartile") {
                    sdkAdSession?.firstQuartile()
                    self.requestTrackingEvents(info!.adTrackingEvents?.firstQuartile!)
                }
            }
            if duration > infoDuration * 0.50 {
                dispatchOnceForQurtileEvents.once(token: "midpoint") {
                    sdkAdSession?.midpoint()
                    self.requestTrackingEvents(info!.adTrackingEvents?.midpoint!)
                }
            }
            if duration > infoDuration * 0.75 {
                dispatchOnceForQurtileEvents.once(token: "thirdQuartile") {
                    sdkAdSession?.thirdQuartile()
                    self.requestTrackingEvents(info!.adTrackingEvents?.thirdQuartile!)
                }
            }
        }
    }
    
    deinit {
        if (player != nil) {
            player!.pause()
        }
        cleanup()
    }
    
    func replaceVideoViewInterface(_ interface1: IASVideoViewInterface?, with interface2: IASVideoViewInterface?) {
        interface1?.videoView?.setPlayer(nil)
        videoViewInterface = interface2
        setupVideoViewInterface()
    }
    
    func setupVideoViewInterface() {
        videoViewInterface?.videoView?.setPlayer(player)
        if let sdkAdSession = sdkAdSession
        {
            sdkAdSession.registerAdView(videoViewInterface?.mainView)
            sdkAdSession.start()
            let properties = OMIDVASTProperties(autoPlay: true, position: OMIDPosition.standalone)
            sdkAdSession.loaded(properties)
            sdkAdSession.beginToRenderImpression()
        }
        self.requestImpressions(info!.impressions!)
        self.requestTrackingEvents(info!.adTrackingEvents?.start!)
    }
    
    func requestImpressions(_ impressions: [OMIDImpression]) {
        for (_, obj) in impressions.enumerated() {
            loadURL(obj.impressionUrl)
        }
    }
    
    func requestTrackingEvents(_ trackingEvents: [OMIDTrackingEvent]?) {
        if let trackingEvents = trackingEvents{
            for (_, obj) in trackingEvents.enumerated() {
                loadURL(obj.trackingUrl)
            }
        }
    }
    
    func loadURL(_ urlString: String?) {
        let url = URL(string: urlString ?? "")
        IASNetworkHelper.loadData(with: url, completionHandler: { data in
        }, errorHandler: {_ in })
    }
    
    
    // some code in functions addVolumeListener, removeVolumeListener, observeValueForKeyPath are commented because app get crashed on multiad scenarios.
    // Commented code previously used for send volume change events.
    func addVolumeListener() {
        do {
            if #available(iOS 10.0, *) {
                try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default,options: .mixWithOthers)
            } else {
            }
        } catch {
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
        }
    }
    
    func removeVolumeListener() {
    }
    
    func volumeChnaged(_ volume: Float) {
        if (sdkAdSession != nil) {
            sdkAdSession!.volumeChange(CGFloat(volume))
        }
    }
    
    // MARK: IASVideoDelegate
    func skipButtonTapped() {
        skip()
    }
        
    func videoTapped() {
        if !(player != nil) {
            return
        }
        sdkAdSession!.adUserInteraction(with: OMIDInteractionType.click)
        if info!.clickThroughUrl != nil {
            if let url = URL(string: info!.clickThroughUrl!) {
                UIApplication.shared.openURL(url)
            }
        } else {
            if state == .kPlayerPaused {
                resumePlayer()
            } else {
                pause()
            }
        }
    }
}
