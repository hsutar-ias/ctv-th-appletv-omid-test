//
//  SDKProvider.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 11/07/23.
//

import Foundation
import UIKit
/**
 - SDKProvider class ia having a funstions used for configure ad configuration view with all available options
 */
open class SDKProvider {
    
    open var bannerTypes : Array<String>!
    open var name : String!
    open var adSize: CGSize? {
        return CGSize.zero
    }
    
    open var omidNamespace: String? {
        return "IAS"
    }
    
    open func initialize() {}
    
    func setConfig(_ config: Config) {
    }
    
    open func showSplashAd(){}
    
    func configureWebServerLogging() {
    }
    
    open func supportBannerType() -> Bool {
        return false
    }
    
    open func supportBannerUrl() -> Bool {
        return false
    }
    
    open func supportContentUrl() -> Bool {
        return false
    }
    
    open func supportPartnerName() -> Bool {
        return false
    }
    
    open func supportUserAgent() -> Bool {
        return false
    }
    
    open func supportLogsWhileScenarioIsExecuted() -> Bool{
        return false
    }
    
    open func supportReloadAd() -> Bool {
        return false
    }
    
    open func isFullscreenTypeSelected() -> Bool {
        return false
    }
    
    open func defaultDimension() -> Int {
        return Config.AdDimension.kDim320_50.rawValue
    }
    
    open func supportWebViewType() -> Bool {
        return false
    }
    
    open func supportWebServerLogging() -> Bool {
        return false
    }
    
    open func webServerPort() -> Int {
        return 0
    }
    
    open func creativesVersion() -> String {
        return "v013"
    }
    
    open func libraryVersion() -> String {
        return ""
    }
    
    open func isFullscreenType(adType: Int) -> Bool {
        return false
    }
    
    open func supportScenario(_ scenario: Int) -> Bool {
        return false
    }
    
    open func supportDimension(_ dimension: Int) -> Bool
    {
        return false
        
    }
    open func supportHiddenReason(_ reason: Int) ->  Bool{
        return true
    }
    
    open func supportDifferentVASTVersion() -> Bool {
        return false
    }
    
    func createAdSource(with controller: UIViewController?) -> AdSource? {
        return nil
    }
    
    func createHiddenAdSource(with controller: UIViewController?) -> AdSource? {
        return nil
    }
    
    func createNoAdViewHiddenAdSource(with controller: UIViewController?) -> AdSource? {
        return nil
    }
}
