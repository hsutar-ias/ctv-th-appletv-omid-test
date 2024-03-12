//
//  SdkAdSession.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 28/07/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//
import Foundation
/**
 This class is used for creating adSession, register webview, captured adEvents and finish adSession
 */
class SdkAdSession: NSObject {
    private var adSession: OMIDAdSession?
    private var adConfiguration: OMIDAdSessionConfiguration?
    private var isStarted = false
    public var nativeMedia = false
    
    var _adEvents : OMIDAdEvents?
    private var adEvents: OMIDAdEvents?{
       if !(_adEvents != nil) {
            do{
                _adEvents = try OMIDAdEvents.init(adSession: adSession!)
            }
            catch let error {
                print("\(error)")
            }
            logMessage("adEvents created")
        }
        return _adEvents
    }
    
    init(adSession session: OMIDAdSession, adConfiguration configuration: OMIDAdSessionConfiguration?) {
        super.init()
        adSession = session
        adConfiguration = configuration
        logMessage("session created")
        do{
            _adEvents = try OMIDAdEvents.init(adSession: adSession!)
            logMessage("adEvents created")
        }
        catch let error{
            print("\(error)")
        }
    }
    
    var _mediaEvents : OMIDMediaEvents? = nil
    var mediaEvents: OMIDMediaEvents? {
        if (_mediaEvents == nil) {
            do{
                _mediaEvents = try OMIDMediaEvents.init(adSession: adSession!)
            }
            catch let error{
                print("\(error)")
            }
            logMessage("mediaEvents created")
        }
        return _mediaEvents
    }
    func logMessage(_ message: String) {
        print("SdkAdSession: \(getSdkAdSessionId()) \(message )")
    }
    
    func getSdkAdSessionId() -> String {
        return adSession!.perform(Selector(("identifier")))?.takeUnretainedValue() as! String
    }
    
    func finish() {
        adSession!.finish()
        logMessage("finish")
    }
    func adView() -> UIView? {
        if adSession != nil {
            return adSession!.mainAdView
        }
        return nil
    }
    func registerAdView(_ view: UIView?) {
        adSession!.mainAdView = view
        logMessage("registerAdView - attached = \(view?.window != nil ? "YES" : "NO")")
    }
    
    func start() {
        //        print(adEvents?)
        if nativeMedia {
            self.mediaEvents
        }
        adSession!.start()
        logMessage("start")
        isStarted = true
    }
    
    func loaded() {
        do{
            try adEvents!.loaded()
        }
        catch let error{
            print("\(error)")
        }
        logMessage("loaded")
    }

    func loaded(_ properties: OMIDVASTProperties) {
        if let adEvents = adEvents{
            do{
                try adEvents.loaded(with: properties)
            }
            catch let error{
                print("\(error)")
            }
            logMessage("loaded vast")
        }
        
    }
    func beginToRenderImpression() {
        if adConfiguration!.impressionOwner.rawValue == OMIDOwner.nativeOwner.rawValue
        {
            do{
                try adEvents!.impressionOccurred()
            }
            catch let error{
                print("\(error)")
            }
            logMessage("beginToRenderImpression")
        }
    }
    
    func addFriendlyObstruction(_ friendlyObstruction: UIView?, purpose: OMIDFriendlyObstructionType, detailedReason reason: String?) {
        do{
            try adSession?.addFriendlyObstruction(friendlyObstruction!, purpose: purpose, detailedReason: reason)
        }
        catch let error {
            print("\(error)")
        }
        logMessage("addFriendlyObstruction")
    }
    
    
    func omidAdSession() -> OMIDAdSession? {
        return adSession
    }
    
    func setNativeMedia(_ nativeMedia: Bool) {
        self.nativeMedia = nativeMedia
        logMessage("native media")
    }
    
    func playerStart(withDuration duration: CGFloat, volume: CGFloat) {
        if let mediaEvents = mediaEvents{
            mediaEvents.start(withDuration: duration, mediaPlayerVolume: volume)
            logMessage("media start")
        }
    }

    func playerPause() {
        mediaEvents!.pause()
        logMessage("media pause")
    }

    func resume() {
        mediaEvents!.resume()
        logMessage("media resume")
    }
    
    func firstQuartile() {
        mediaEvents!.firstQuartile()
        logMessage("media firstQuartile")
    }

    func midpoint() {
        mediaEvents!.midpoint()
        logMessage("media midpoint")
    }

    func thirdQuartile() {
        mediaEvents!.thirdQuartile()
        logMessage("media thirdQuartile")
    }
    
    func playerStateChange(to state: OMIDPlayerState) {
        mediaEvents!.playerStateChange(to: state)
        logMessage("media playerStateChange \(omidPlayerStateStringValue(state))")
    }
    
    func adUserInteraction(with type: OMIDInteractionType) {
        mediaEvents!.adUserInteraction(withType: type)
        logMessage("media adUserInteraction \(adUserInteractionStringValue(type))")
    }

    func volumeChange(_ volume: CGFloat) {
        if let mediaEvents = mediaEvents {
            if isStarted {
                mediaEvents.volumeChange(to: volume)
                logMessage("media volumeChange \(volume)")
            }
        }
    }

    func playerSkipped() {
        mediaEvents!.skipped()
        logMessage("media skipped")
    }

    func playerComplete() {
        mediaEvents!.complete()
        logMessage("media complete")
    }
    
    func error(with type: OMIDErrorType, playerError error: String?) {
        adSession!.logError(withType: type, message: error!)
        logMessage("error \(errorTypeStringValue(type)) \(error ?? "")")
    }
    
    func omidPlayerStateStringValue(_ state: OMIDPlayerState) -> String? {
        switch state {
        case OMIDPlayerState.normal:
            return "normal"
        case OMIDPlayerState.expanded:
            return "expanded"
        case OMIDPlayerState.collapsed:
            return "collapsed"
        case OMIDPlayerState.minimized:
            return "minimized"
        case OMIDPlayerState.fullscreen:
            return "fullscreen"
        }
    }
    
    
    func adUserInteractionStringValue(_ type: OMIDInteractionType) -> String? {
        switch type {
        case OMIDInteractionType.click:
            return "clik"
        case OMIDInteractionType.acceptInvitation:
            return "acceptInvitation"
        }
    }

    func errorTypeStringValue(_ type: OMIDErrorType) -> String? {
        switch type {
        case OMIDErrorType.media:
            return "media/video"
        case OMIDErrorType.generic:
            return "generic"
        }
    }
}
