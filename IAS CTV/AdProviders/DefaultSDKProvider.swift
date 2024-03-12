//
//  DefaultSDKProvider.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 13/07/23.
//

import Foundation
import UIKit
//import IAS_OMSDK
import OM_TEST
/**
 - DefaultSDKProvider extend BaseSDKProvider and impement BaseSDKProvider functions
 - Configure GCDWebserver for console logs - configureWebServerLogging()
 */
class DefaultSDKProvider:  BaseSDKProvider{
    
    private var serverPort = 0

    override func dataPlistSuffix() -> String? {
        return "IAS"
    }


    override func supportBannerUrl() -> Bool {
        return true
    }

    override func supportContentUrl() -> Bool {
        return true
    }

    override func supportLogsWhileScenarioIsExecuted() -> Bool {
        return false
    }

    override func supportReloadAd() -> Bool {
        return false
    }

    override func defaultDimension() -> Int {
        let bannerType =  IASAdType(rawValue: config.adBannerType)
        switch bannerType {
        case .kIASNativeVideo:
            return Config.AdDimension.kDim300_250.rawValue
        case .kIASNativeAudio:
            return Config.AdDimension.kDim300_250.rawValue
        default:
            return Config.AdDimension.kDim320_50.rawValue
        }
    }

    override func isFullscreenType(adType: Int) -> Bool {
        return true;
    }

    override func supportScenario(_ scenario: Int) -> Bool {
        switch self.config.adBannerType {
        case IASAdType.kIASNativeVideo.rawValue:
            return scenario != Config.AdScenario.kSimpleScenario.rawValue
        case IASAdType.kIASNativeAudio.rawValue:
            return scenario == Config.AdScenario.kSimpleScenario.rawValue
        default:
            return super.supportScenario(scenario)
        }
    }

    override func supportDimension(_ dimension: Int) -> Bool {
        switch config.adBannerType {
        case IASAdType.kIASNativeVideo.rawValue:
            return dimension == Config.AdDimension.kDim300_250.rawValue || dimension == Config.AdDimension.kDimCustom.rawValue

        case IASAdType.kIASNativeAudio.rawValue:
            return dimension == Config.AdDimension.kDim300_250.rawValue

        default:
            return dimension != Config.AdDimension.kDim2000_2000.rawValue
        }
    }
    
    override func supportUserAgent() -> Bool {
        switch config.adBannerType {
        case IASAdType.kIASNativeVideo.rawValue:
            return false

        case IASAdType.kIASNativeAudio.rawValue:
            return false
        default:
            return true
        }
    }

    override func supportHiddenReason(_ reason: Int) -> Bool {
        return true
    }

    override func supportWebViewType() -> Bool {
        return false;
    }


    override func createAdSource(with controller: UIViewController?) -> AdSource? {
        IASPartner.setIASPartner(Config.sharedConfig.partnerName()!, Config.sharedConfig.adPartnerVersion!)

        IASUserAgent.setIASUserAgent(Config.sharedConfig.userAgent()!)

        if let adType = IASAdType(rawValue: config.adBannerType) {

            switch adType {
            case .kIASNativeVideo:
                return NativeVideoAdSource(controller: controller)

//            case .kIASNativeAudio:
//                return NativeAudioAdSource(controller: controller)

            default:
                return NativeVideoAdSource(controller: controller)
            }
        }
        return nil
    }
    override func initialize() {
        super.initialize()
        IAS.setup()
//        IAS.provideCreativesURL(IASUtility.creativesURLpath(withVersion: self.creativesVersion()))
    }

    override func supportWebServerLogging() -> Bool {
        return true
    }
    override func webServerPort() -> Int {
        return serverPort
    }

    override func libraryVersion() -> String {
        return IAS.libraryVersion()!
    }

    func provideCreativesURL(url : String) {
        IASCreativesURLUtil.shared.setURL(url)
    }

//    override func configureWebServerLogging() {
//        let webServer = GCDWebServer()
//        GCDWebServer.setLogLevel(4)
//        webServer.addDefaultHandler(
//            forMethod: "GET",
//            request: GCDWebServerRequest.self) { request in
//                DispatchQueue.main.async(execute: {
//                    var path: String? = nil
//                    path = "\(request.url)"
//                    let logMsg = AppLog.sharedLog.parseMessage(msg: path!, port: self.serverPort)
//                    print(logMsg)
//                    AppLog.sharedLog.addLog(log:logMsg)
//                })
//                return nil
//        }
//        var options: [AnyHashable : Any] = [:]
//        options[GCDWebServerOption_BindToLocalhost] = NSNumber(value: true)
//        options[GCDWebServerOption_BonjourName] = "testServer"
//        options[GCDWebServerOption_AutomaticallySuspendInBackground] = NSNumber(value: false)
//        do {
//            try webServer.start(options: options as? [String : Any])
//        } catch {
//        }
//        serverPort = Int(webServer.port)
//        IAS.provideServerPort(serverPort)
//        if let serverURL = webServer.serverURL {
//            print("Visit \(serverURL) in your browser")
//        }
//    }

    override func supportDifferentVASTVersion() -> Bool {
        switch config.adBannerType {
        case IASAdType.kIASNativeVideo.rawValue:
            return true

        default:
            return false
        }
    }

    func creativesVersion() -> String? {
        return "v013"
    }

}
