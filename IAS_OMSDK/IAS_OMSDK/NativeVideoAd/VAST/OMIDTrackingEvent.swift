//
//  OMIDTrackingEvent.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class OMIDTrackingEvent: NSObject {
    var trackingUrl: String?
    var event: String?

    override init() {
        super.init()
            trackingUrl = "none"
            event = "none"
    }
}
