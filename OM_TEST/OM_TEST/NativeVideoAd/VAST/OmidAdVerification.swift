//
//  OmidAdVerification.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class OmidAdVerification: NSObject {
    var omidVerifications: [OmidVerification]?
    
    override init() {
        super.init()
        omidVerifications = []
    }
    
    func merge(_ adVerification: OmidAdVerification?) {
        for (idx, obj) in (adVerification!.omidVerifications)!.enumerated() {
            if omidVerifications!.contains(obj) {
                omidVerifications![idx] = obj
            } else {
                omidVerifications?.append(obj)
            }
        }
        
    }
}
