//
//  NativeVideoAdSource.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 02/08/23.
//

import Foundation
//import IAS_OMSDK
import OM_TEST

class NativeVideoAdSource: BaseAdSource<UIView>, IASVideoAdDelegate {
    var videoAd: IASVideoAd?
    override func createAdView() -> UIView? {
        if !(videoAd != nil) {
            videoAd = IASVideoAd()
            videoAd!.delegate = self
        }
        
        let view = videoAd!.view
        view()!.translatesAutoresizingMaskIntoConstraints = false
        let url = IASUtility.adUrl(
            with: Config.sharedConfig.adBannerURL,
            index: self.index,
            adType: Config.sharedConfig.adBannerType,
            version: Config.sharedConfig.creativesVersion,
            vastVersion: Config.sharedConfig.vastVersion)
        
        videoAd!.loadAd(with: url)
        return view()
    }
    
    
    override func viewWillAppear() {
        videoAd!.viewWillAppear()
    }

    override func viewWillDisappear() {
        videoAd!.viewWillDisappear()
    }

    override func infoViewControllerWillAppear() {
        videoAd!.viewWillDisappear()
    }

    override func infoViewControllerWillDisappear() {
        videoAd!.viewWillAppear()
    }
    
    // MARK: IASVideoAdDelegate
    func onVideoAdLoaded(_ videoAd: IASBaseVideoAd?) {
        self.videoAd!.showAd()
    }

    func onVideoAdStarted(_ videoAd: IASBaseVideoAd?) {

    }

    func onVideoAdLoadError(_ videoAd: IASBaseVideoAd?) {
        print("Failed to load ad")
    }

    func onVideoAdStopped(_ videoAd: IASBaseVideoAd?) {

    }
    
    var presentingViewController: UIViewController {
        return controller!
    }

    func getContentURL() -> String? {
        return Config.sharedConfig.contentUrl.getContentUrl()
    }
}
