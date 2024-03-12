//
//  OMIDAdTrackingEvents.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class OMIDAdTrackingEvents: NSObject {
    var start: [OMIDTrackingEvent]?
    var firstQuartile: [OMIDTrackingEvent]?
    var midpoint: [OMIDTrackingEvent]?
    var thirdQuartile: [OMIDTrackingEvent]?
    var complete: [OMIDTrackingEvent]?
    
    override init() {
        super.init()
        start = [OMIDTrackingEvent]()
        firstQuartile = [OMIDTrackingEvent]()
        midpoint = [OMIDTrackingEvent]()
        thirdQuartile = [OMIDTrackingEvent]()
        complete = [OMIDTrackingEvent]()
    }
}
