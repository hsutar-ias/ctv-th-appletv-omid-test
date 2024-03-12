//
//  BaseSDKProvider.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 13/07/23.
//

import Foundation
import UIKit
/**
 - BaseSDKProvider extends SDKProvider and implement its funstions
 */
class BaseSDKProvider: SDKProvider {
    let BANNER_TYPE_KEY = "BannerType"
    let NAME_KEY = "Name"
    var config: Config!
   
    override func initialize() {
        super.initialize()
        let dict = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "data-IAS", ofType: "plist") ?? "")
        bannerTypes = dict?.value(forKey: BANNER_TYPE_KEY) as? Array<String>
        name = dict?.value(forKey: NAME_KEY) as? String
    }
    
    override func setConfig(_ config: Config) {
        self.config = config
    }
    
    override func creativesVersion() -> String {
        return super.creativesVersion()
    }
    
    override func supportBannerType() -> Bool {
        return true
    }
    
    override func supportBannerUrl() -> Bool {
        return true
    }
    
    override func supportContentUrl() -> Bool {
         return false
     }
    
    override func supportReloadAd() -> Bool {
        return true
    }
    
    override func supportLogsWhileScenarioIsExecuted() -> Bool {
        return true
    }
    
    override func supportPartnerName() -> Bool {
        return true
    }
    
    override func supportUserAgent() -> Bool {
        return true
    }
    
    override var adSize: CGSize? {
        return isFullscreenTypeSelected() ? CGSize.zero : Config.sharedConfig.customAdSize
    }
    
    override func isFullscreenTypeSelected() -> Bool {
        return self.isFullscreenType(adType: config.adBannerType)
    }
    
    override func defaultDimension() -> Int {
        return Config.AdDimension.kDim320_50.rawValue
    }
   
    override func isFullscreenType(adType: Int) -> Bool {
        false
    }
    
    override func supportScenario(_ scenario: Int) -> Bool {
        if isFullscreenTypeSelected() {
            return scenario == Config.AdScenario.kSimpleScenario.rawValue
        }

        return true
    }
    
    override func supportDimension(_ dimension: Int) -> Bool {
        return true
    }
    
    override func supportWebViewType() -> Bool {
        return true
    }
    
    override func createAdSource(with controller: UIViewController?) -> AdSource? {
        return nil
    }
    
    override func createHiddenAdSource(with controller: UIViewController?) -> AdSource? {
        return nil
    }
    
    override func createNoAdViewHiddenAdSource(with controller: UIViewController?) -> AdSource? {
        return nil
    }
    
    override func webServerPort() -> Int {
        return 80
    }
    
    override func showSplashAd() {
    }
    
    override func supportWebServerLogging() -> Bool {
        return false
    }
    
    override func supportDifferentVASTVersion() -> Bool {
        return false
    }
    
    override func configureWebServerLogging() {
    }
    
    override func libraryVersion() -> String {
        return super.libraryVersion()
    }
    
    override func supportHiddenReason(_ reason: Int) -> Bool {
        return true
    }
    
    func dataPlistSuffix() -> String? {
        return ""
    }

    func name() -> String? {
        return name
    }

    func omidNamespace() -> String? {
        return dataPlistSuffix()
    }
    
}
