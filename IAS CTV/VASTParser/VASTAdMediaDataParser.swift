//
//  VASTAdMediaDataParser.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 13/05/21.
//

import Foundation

class VASTAdMediaDataParser: VASTBaseParser {
    open var adMediaData: AdMediaData? {
        return nil
    }
    
    open var adTrackingEvents: OMIDAdTrackingEvents? {
        return nil
    }
}

class VASTLinearParser: VASTAdMediaDataParser {
    var _adMediaData: LinearAdMediaData?
    var _adTrackingEvents: OMIDAdTrackingEvents? = nil
    var trackingEvent: OMIDTrackingEvent? = nil
    var isMediaFile: Bool = false
    var isTrackingEvent: Bool = false
    var mediaFileExtension : String = ""
    var SUPPORTED_MEDIA_FORMAT = "video/mp4";
    var SUPPORTED_MEDIA_FORMAT1 = "video/3gpp";
    var SUPPORTED_MEDIA_FORMAT2 = "audio/mp3";
    
    override var adMediaData: AdMediaData? {
        if _adMediaData == nil {
            _adMediaData = LinearAdMediaData()
        }
        return _adMediaData
    }
    
    override var adTrackingEvents: OMIDAdTrackingEvents? {
        if _adTrackingEvents == nil {
            _adTrackingEvents = OMIDAdTrackingEvents()
        }
        return _adTrackingEvents
    }
    
    override func didStartElement(_ elementName: String?, attributes attributeDict: [String : String]?) {
        isMediaFile = (elementName == "MediaFile")
        if elementName ==  "MediaFile"{
            mediaFileExtension = String(attributeDict?["type"] ?? "")
            print(mediaFileExtension)
        }
        if elementName == "Tracking" {
            isTrackingEvent = true
            trackingEvent = OMIDTrackingEvent()
            trackingEvent?.event = attributeDict?["event"] ?? ""
        }
    }
    
    override func didEndElement(_ elementName: String?, value: String?) {
        isMediaFile = false
        isTrackingEvent = false
        
        if elementName == "Duration" {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss.SSS"
            var temp = ""
            temp = value?.trimmingCharacters(in: CharacterSet.whitespaces) ?? ""
            if !temp.contains(".") {
                temp += ".000"
            }
            let date = formatter.date(from: temp)
            let date1 = formatter.date(from: "00:00:00.000")
            if let date1 = date1 {
                (adMediaData as? LinearAdMediaData)?.duration = date?.timeIntervalSince(date1)
            }
        } else if elementName == "Tracking" {
            (adMediaData as? LinearAdMediaData)?.adTrackingEvents = adTrackingEvents
        }
    }
    
    
    override func foundCDATA(_ CDATABlockString: String?) {
        if isMediaFile {
            if (mediaFileExtension == SUPPORTED_MEDIA_FORMAT || mediaFileExtension == SUPPORTED_MEDIA_FORMAT1 || mediaFileExtension == SUPPORTED_MEDIA_FORMAT2){
                (adMediaData as? LinearAdMediaData)?.videoUrl = CDATABlockString
            }
            
        } else if isTrackingEvent {
            trackingEvent?.trackingUrl = CDATABlockString ?? ""
            if trackingEvent?.event == "start" {
                adTrackingEvents?.start.append(trackingEvent!)
            } else if trackingEvent?.event == "firstQuartile" {
                adTrackingEvents?.firstQuartile.append(trackingEvent!)
            } else if trackingEvent?.event == "midpoint" {
                adTrackingEvents?.midpoint.append(trackingEvent!)
            } else if trackingEvent?.event == "thirdQuartile" {
                adTrackingEvents?.thirdQuartile.append(trackingEvent!)
            } else if trackingEvent?.event == "complete" {
                adTrackingEvents?.complete.append(trackingEvent!)
            } else if trackingEvent?.event == "skip" {
                adTrackingEvents?.skip.append(trackingEvent!)
            } else if trackingEvent?.event == "mute" {
                adTrackingEvents?.mute.append(trackingEvent!)
            } else if trackingEvent?.event == "unmute" {
                adTrackingEvents?.unmute.append(trackingEvent!)
            } else if trackingEvent?.event == "pause" {
                adTrackingEvents?.pause.append(trackingEvent!)
            } else if trackingEvent?.event == "resume" {
                adTrackingEvents?.resume.append(trackingEvent!)
            }
        }
    }
}
