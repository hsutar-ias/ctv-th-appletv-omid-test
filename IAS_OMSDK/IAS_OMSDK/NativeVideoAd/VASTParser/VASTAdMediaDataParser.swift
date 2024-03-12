//
//  VASTAdMediaDataParser.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
let DURATION = "Duration"
let MEDIA_FILE = "MediaFile"
let CLICK_THROUGH = "ClickThrough"
let TRACKING = "Tracking"
let START = "start"
let FIRSTQUARTILE = "firstQuartile"
let MIDPOINT = "midpoint"
let THIRDQUARTILE = "thirdQuartile"
let COMPLETE = "complete"

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
    var isMediaFile: Bool = false
    var isTrackingEvent: Bool = false
    var isClickThrough = false
    override var adMediaData: AdMediaData? {
        if _adMediaData == nil {
            _adMediaData = LinearAdMediaData()
        }
        return _adMediaData
    }
    
    override var adTrackingEvents: OMIDAdTrackingEvents? {
        if _adTrackingEvents == nil {
            _adTrackingEvents = OMIDAdTrackingEvents()
            self.adTrackingEvents!.start = [OMIDTrackingEvent]()
            self.adTrackingEvents!.firstQuartile = [OMIDTrackingEvent]()
            self.adTrackingEvents!.midpoint = [OMIDTrackingEvent]()
            self.adTrackingEvents!.thirdQuartile = [OMIDTrackingEvent]()
            self.adTrackingEvents!.complete = [OMIDTrackingEvent]()
        }
        return _adTrackingEvents
    }
    
    var _trackingEvent: OMIDTrackingEvent? = nil
    var trackingEvent: OMIDTrackingEvent?
    {
        if !(_trackingEvent != nil)
        {
            _trackingEvent = OMIDTrackingEvent()
        }
        return _trackingEvent
    }
    
    override func didStartElement(_ elementName: String?, attributes attributeDict: [String : String]?) {
        isMediaFile = (elementName == MEDIA_FILE)
        isClickThrough = (elementName == CLICK_THROUGH)
        if elementName == TRACKING {
            isTrackingEvent = true
            _trackingEvent = OMIDTrackingEvent()
            trackingEvent?.event = attributeDict?["event"] ?? ""
        }
    }
    
    override func didEndElement(_ elementName: String?, value: String?) {
        isMediaFile = false
        isTrackingEvent = false
        if elementName == DURATION {
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
                (adMediaData as? LinearAdMediaData)?.duration = (date?.timeIntervalSince(date1))!
            }
        } else if elementName == TRACKING {
            (adMediaData as? LinearAdMediaData)?.adTrackingEvents = adTrackingEvents
        }
    }
    
    
    override func foundCDATA(_ CDATABlockString: String?) {
        if isMediaFile {
            (adMediaData as? LinearAdMediaData)?.mediaUrl = CDATABlockString
        } else if isClickThrough {
            (adMediaData as? LinearAdMediaData)?.clickThroughUrl = CDATABlockString
        }
        else if isTrackingEvent {
            trackingEvent!.trackingUrl = CDATABlockString
            if trackingEvent!.event == START {
                adTrackingEvents?.start?.append(trackingEvent!)
            }
            else if trackingEvent!.event == FIRSTQUARTILE {
                adTrackingEvents?.firstQuartile?.append(trackingEvent!)
            }  else if trackingEvent!.event == MIDPOINT {
                adTrackingEvents?.midpoint?.append(trackingEvent!)
            } else if trackingEvent!.event == THIRDQUARTILE {
                adTrackingEvents?.thirdQuartile?.append(trackingEvent!)
            } else if trackingEvent!.event == COMPLETE {
                adTrackingEvents?.complete?.append(trackingEvent!)
            }
        }
    }
}
