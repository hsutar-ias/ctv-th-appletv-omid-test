//
//  OMIDAdTrackingEvents.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 13/05/21.
//

import Foundation

class OMIDAdTrackingEvents: NSObject {
    var start = [OMIDTrackingEvent]()
    var firstQuartile = [OMIDTrackingEvent]()
    var midpoint = [OMIDTrackingEvent]()
    var thirdQuartile = [OMIDTrackingEvent]()
    var complete = [OMIDTrackingEvent]()
    var mute = [OMIDTrackingEvent]()
    var unmute = [OMIDTrackingEvent]()
    var skip = [OMIDTrackingEvent]()
    var pause = [OMIDTrackingEvent]()
    var resume = [OMIDTrackingEvent]()
}

class OMIDTrackingEvent: NSObject {
    var trackingUrl = "none"
    var event = "none"
}
