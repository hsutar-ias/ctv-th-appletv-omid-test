//
//  IASUtility.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 02/08/23.
//

import Foundation

class IASUtility {
    class func adUrl(with url: String?, index: Int, adType: Int, version: String?) -> URL? {
        
        let urlString = (self.transformString(url, index: index, adType: adType, version: version, vastVersion: ""))
        guard let urlStr = urlString else {
            return URL(string: "")!
        }
        let urlURL = URL(string: urlStr)
        return urlURL
    }
    
    
    class func adUrl(with url: String?, index: Int, adType: Int, version: String?, vastVersion: Config.VASTVersion) -> URL? {
        
        return URL(string: self.transformString(url, index: index, adType: adType, version: version, vastVersion: self.getStringFrom(vastVersion))!)
    }
    
    class func transformString(_ url: String?, index: Int, adType: Int, version: String?, vastVersion: String?) -> String?
    {
        var urlStr = url
        if (url == nil)
        {
            urlStr = "\(IASConfig.DEFAULT_HOST)\(IASConfig.DEFAULT_CREATIVES_PATH)"
            
            if index == 0 {
                let adType = IASAdType(rawValue: adType)
                switch adType
                {
                case .kIASNativeVideo:
                    urlStr = "\(urlStr!)\(IASConfig.DEFAULT_STATIC_VIDEO_AD_URL)"
                    urlStr = string(urlStr, replaceVASTVersion: vastVersion)!
                    break
                    
                case .kIASNativeAudio:
                    urlStr = "\(urlStr!)\(IASConfig.DEFAULT_STATIC_VIDEO_AD_URL)"
                    urlStr = string(urlStr, replaceVASTVersion: vastVersion)!
                    break
               

                default:
                    break
                }
            }
            else{
                let adType = IASAdType(rawValue: adType)
                switch adType {
                case .kIASNativeVideo:
                    let stringValue = string(IASConfig.DEFAULT_DYNAMIC_VIDEO_AD_URL, replace: index)
                    urlStr = urlStr! + stringValue!
                    urlStr = string(urlStr, replaceVASTVersion: vastVersion)!
                    break
              
                case .kIASNativeAudio:
                    let stringValue = string(IASConfig.DEFAULT_DYNAMIC_VIDEO_AD_URL, replace: index)
                    urlStr = urlStr! + stringValue!
                    urlStr = string(urlStr, replaceVASTVersion: vastVersion)!
                    break

                default:
                    break
                    
                }
                urlStr = withoutEncodedString(urlStr, replace: index)!
            }
        }
        else {
            urlStr = string(string(url, replaceVersion: version), replace: index)!
        }
        
        return string(urlStr, replaceVersion: version)
    }
    
    class func string(_ url: String?, replace index: Int) -> String? {
        let indexStr = String(format: "%lu", index)
        return url?.replacingOccurrences(of: IASConfig.URL_ID_TEMPLATE , with: indexStr)
    }
    
    class func addServerPort(_ url: String?) -> String? {
        var endOfURL = ""
        if Config.sharedConfig.sdkProvider.supportWebServerLogging()
        {
            let serverPort = Config.sharedConfig.sdkProvider.webServerPort()
            endOfURL = String(format: "?serverPort=%lu", serverPort)
        }
        return (url ?? "") + endOfURL
    }
    
    class func string(_ url: String?, replaceVASTVersion vastVersion: String?) -> String?{
        return url?.replacingOccurrences(of: Config.URL_VAST_VERSION_TEMPLATE, with: vastVersion ?? "")
    }
    
    class func withoutEncodedString(_ url: String?, replace index: Int) -> String? {
        let indexStr = String(format: "%lu", index)
        return url?.replacingOccurrences(of: IASConfig.URL_ID_TEMPLATE, with: indexStr)
    }
    
    class func string(_ url: String?, replaceVersion version: String?) -> String? {
        return url?.replacingOccurrences(of: Config.URL_CREATIVES_VERSION_TEMPLATE, with: version ?? "")
    }
    
    class func creativesURLpath(withVersion version: String?) -> String? {
        let url = "\(IASConfig.DEFAULT_HOST)\(IASConfig.DEFAULT_CREATIVES_PATH)"
        return self.string(url, replaceVersion: version)
    }
    
    class func getStringFrom(_ vastVersion: Config.VASTVersion) -> String? {
        switch vastVersion {
        case .kVastVersion20:
            return "20"
        case .kVastVersion30:
            return "30"
        case .kVastVersion40:
            return "40"
        case .kVastVersion41:
            return "41"
        case .kVastVersion42:
            return "42"
        }
    }
}
