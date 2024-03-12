//
//  IASNativeVideoAdInfo.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 13/05/21.
//

import Foundation

class IASNativeVideoAdInfo: NSObject {
    var videoUrl: String = ""
    var duration: TimeInterval? = 0.0
    var impressions: [OMIDImpression]?
    var adTrackingEvents: OMIDAdTrackingEvents?
    var adjavaScriptResource:[OmidAdVerification]?
    
    
    class func info(with response: VASTResponse?) -> IASNativeVideoAdInfo? {
        let info = IASNativeVideoAdInfo()
        self.setupInfo(info, with: response)
        return info
    }
    
    class func setupInfo(_ info: IASNativeVideoAdInfo?, with response: VASTResponse?) {
        if response?.ads?.count == 0 {
            return
        }
        let ad = response?.ads?[0] as? Ad
        if ad?.adData is InLineAdData {
            self.setupInfo(info, with: ad?.adData as? InLineAdData)
        } else if ad?.adData is WrapperAdData {
            self.setupInfo(info, with: ad?.adData as? WrapperAdData)
        }
    }
    
    class func setupInfo(_ info: IASNativeVideoAdInfo?, with adData: InLineAdData?) {
        if adData?.creatives?.count == 0 {
            return
        }
        let creative = adData?.creatives?[0] as? AdCreative
        let mediaData = creative?.adData as? LinearAdMediaData
        
        info?.videoUrl = mediaData?.videoUrl ?? ""
        info?.duration = mediaData?.duration
        info?.impressions = adData?.omidImpressions
        info?.adjavaScriptResource = adData?.omidAdVerifications
        info?.adTrackingEvents = mediaData?.adTrackingEvents
    }
    
    class func setupInfo(_ info: IASNativeVideoAdInfo?, with adData: WrapperAdData?) {
        if adData?.vastResponse != nil {
            self.setupInfo(info, with: adData?.vastResponse)
        }
    }
}
