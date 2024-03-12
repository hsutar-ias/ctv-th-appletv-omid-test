//
//  IASBaseVideoAd.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 14/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation

public protocol IASVideoAdDelegate: NSObjectProtocol {
    func onVideoAdLoaded(_ videoAd: IASBaseVideoAd?)
    func onVideoAdStarted(_ videoAd: IASBaseVideoAd?)
    func onVideoAdLoadError(_ videoAd: IASBaseVideoAd?)
    func onVideoAdStopped(_ videoAd: IASBaseVideoAd?)
    var presentingViewController: UIViewController { get  }
    func getContentURL() -> String?
}
/**
- IASBaseVideoAd class extends IASVideoPlayerDelegate and implements it's functions
- This class is a base class of banner Video ad which is used for handling a video scenario
*/
public class IASBaseVideoAd: NSObject, IASVideoPlayerDelegate {
    public weak var delegate: IASVideoAdDelegate?
    var sdkAdSession: SdkAdSession?
    private var _player: IASVideoPlayer?
    private var videoAdLoader: IASVideoAdLoader?
    
    func player() -> IASVideoPlayer? {
        return _player
    }
    func load(with url: URL?) {
    }
    
    public func show() {
    }
    
    public func loadAd(with url: URL?) {
        closeCurrentOmidVideoAdSession()
        let player = playerMode()
        _player = IASVideoPlayer(mode: player)
        _player!.delegate = self
        
        weak var weakSelf = self
        let adUrl = url ?? URL(string: DEFAULT_NATIVE_VIDEO_AD_URL)
        videoAdLoader = IASVideoAdLoader()
        videoAdLoader!.loadAdWithUrl(with: adUrl, completionHandler: { response in
            weakSelf!.onLoadVASTResponse(response)
        }, errorHandler: { error in
            weakSelf!.onError()
        })
    }
    
    public func showAd() {
        prepare()
        _player!.play()
    }
    
    func onLoadVASTResponse(_ response: VASTResponse?) {
        guard let ads = response?.ads else {
            onError()
            return
        }
        guard ads.count > 0 else {
            onError()
            return
        }
        _player!.info = IASNativeVideoAdInfo.info(with: response)
        
        var url = IASCreativesURLUtil.shared.address
        url = url! + DEFAULT_SCRIPT_URL
        createSessionWithScript(from: URL(string: url!))
        delegate!.onVideoAdLoaded(self)
    }
    
    func createOmidAdSession(_ script: String?) {
        let impressionType = OMIDImpressionType.beginToRender
        
        var configuration: OMIDAdSessionConfiguration? = nil
        do {
            configuration = try OMIDAdSessionConfiguration(creativeType: OMIDCreativeType.video, impressionType: impressionType, impressionOwner: OMIDOwner.nativeOwner, mediaEventsOwner: OMIDOwner.nativeOwner, isolateVerificationScripts: false)
        } catch let configError {
            print("\(configError)")
        }
        
        let partner = OMIDPartner(name: IASPartner.partner.name, versionString: IASPartner.partner.version)
        
        var resources: [OMIDVerificationScriptResource]?
        if videoAdLoader!.omidVerificationScriptResource!.count != 0 {
            resources = [OMIDVerificationScriptResource]()
            for (_, resource) in videoAdLoader!.omidVerificationScriptResource!.enumerated() {
                resources!.append(IASNativeDisplayAdInfo.updateVerificationScriptResource(resource)!)
            }
        }
        
        var context: OMIDAdSessionContext? = nil
        do {
            context = try OMIDAdSessionContext(partner: partner!, script: script!, resources: (resources)!, contentUrl: delegate!.getContentURL(), customReferenceIdentifier: "identifier")
        } catch let contextError {
            print("\(contextError)")
        }
                
        var omidAdSession: OMIDAdSession? = nil
        do {
            omidAdSession = try OMIDAdSession(configuration: configuration!, adSessionContext: context!)
        } catch let sessionError {
            print("\(sessionError)")
        }
        sdkAdSession = SdkAdSession(adSession: omidAdSession!, adConfiguration: configuration)
        _player?.sdkAdSession = sdkAdSession
        sdkAdSession?.nativeMedia = true
    }
    
    func onError() {
        sdkAdSession?.error(with: OMIDErrorType.media, playerError: "Failed to load ad response")
        closeCurrentOmidVideoAdSession()
        delegate?.onVideoAdLoadError(self)

    }
    
    func closeCurrentOmidVideoAdSession() {
        sdkAdSession?.finish()
        sdkAdSession = nil
    }
    
    func cleanup() {
        _player!.stop()
        closeCurrentOmidVideoAdSession()
    }
    
    func playerMode() -> IASVideoPlayerMode {
        return .iasVideoBanner
    }
    
    func prepare() {
        
    }
    
    public func trackingWebView() -> UIView? {
        return sdkAdSession?.adView()
    }
    
    // MARK: IASVideoPlayerDelegate
    
    func playerPrepared(_ player: IASVideoPlayer?) {

    }
    
    func playerStarted(_ player: IASVideoPlayer?) {
        delegate!.onVideoAdStarted(self)
    }
    
    func playerStopped(_ player: IASVideoPlayer?) {
        closeCurrentOmidVideoAdSession()
        delegate!.onVideoAdStopped(self)
    }
    
    func playerError(_ player: IASVideoPlayer?) {
        sdkAdSession?.error(with: OMIDErrorType.media, playerError: "Unknown player error")
        closeCurrentOmidVideoAdSession()
        delegate!.onVideoAdStopped(self)
    }
    
    var presentingViewController: UIViewController {
        return delegate!.presentingViewController
    }
    
    func createSessionWithScript(from url: URL?)
    {
        var downloadTask: URLSessionDataTask? = nil
        if let url = url {
            downloadTask = URLSession.shared.dataTask(
            with: url) { data, response, error in
                if (data != nil) && (response as? HTTPURLResponse)?.statusCode != 404 {
                    DispatchQueue.main.async(execute: { [self] in
                        self.createOmidAdSession(String(data: data!, encoding: .ascii))
                    })
                } else {
                    DispatchQueue.main.async(execute: { [self] in
                        self.createOmidAdSession(DEFAULT_SCRIPT)
                    })
                }
            }
        }
        downloadTask?.resume()
    }
}
