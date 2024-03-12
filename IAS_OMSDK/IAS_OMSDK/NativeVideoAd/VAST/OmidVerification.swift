//
//  OmidVerification.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class OmidVerification: NSObject {
    var javaScriptResource: String?
    var verificationParameters: String?
    var vendorKey: String?
    
    override init() {
        super.init()
        vendorKey = "none"
    }
    
    func isEqual(_ other: Any) -> Bool {
        if other == nil || (type(of: self) != type(of: other)) {
            return false
        }

        let ver = other as? OmidVerification
        return (verificationParameters == ver?.verificationParameters) && (javaScriptResource == ver?.javaScriptResource) && (vendorKey == ver?.vendorKey)
    }
    
//    func hash() -> Int {
//        return (vendorKey.hash()) ^ (javaScriptResource.hash()) ^ (verificationParameters.hash())
//    }
}
