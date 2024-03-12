//
//  LinearAdMediaData.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class LinearAdMediaData: AdMediaData {
    var mediaUrl: String?
    var clickThroughUrl: String?
    var duration: TimeInterval = 0.0
    var adTrackingEvents: OMIDAdTrackingEvents?
}
