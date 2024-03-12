//
//  OMIDAdImpression.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class OMIDAdImpression: NSObject {
    var omidImpressions: [OMIDImpression]?

    override init() {
        super.init()
        omidImpressions = []
    }
}
