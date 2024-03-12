//
//  IASNativeVideoAdInfo.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
/**
- IASNativeVideoAdInfo class used to set a infomation about video ad
- Set a videoUrl, clickThroughUrl, duration, impression and adTrackingEvents
*/
class IASNativeVideoAdInfo: IASNativeVASTAdInfo
{
    var videoUrl: String?
    var clickThroughUrl: String?
    var duration: TimeInterval = 0.0
    var impressions: [OMIDImpression]?
    var adTrackingEvents: OMIDAdTrackingEvents?
    
    convenience init?(vastResponse response: VASTResponse?) {
        self.init()
        let info = IASNativeVideoAdInfo()
        IASNativeVideoAdInfo.self.setupInfo(info, with: response)
    }
    
    override func mapInfo(with adData: InLineAdData?) {
        if adData?.creatives?.count == 0 {
            return
        }
        let creative = adData?.creatives![0] as? AdCreative
        let mediaData = creative?.adData as? LinearAdMediaData
        videoUrl = mediaData?.mediaUrl
//        videoUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        clickThroughUrl = mediaData?.clickThroughUrl
        duration = mediaData!.duration
        impressions = adData?.omidImpressions
        adTrackingEvents = mediaData?.adTrackingEvents
    }
}
