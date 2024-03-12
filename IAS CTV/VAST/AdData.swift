//
//  AdData.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 12/05/21.
//

import Foundation

struct Ad {
    var adData : AdData?
}

class AdData: NSObject {
    var omidAdVerifications: [OmidAdVerification]? = []
    var omidImpressions: [OMIDImpression]? = []
}

class AdCreative: NSObject {
    var adData: AdMediaData?
}

class AdMediaData: NSObject{
    
}

class LinearAdMediaData: AdMediaData {
    var videoUrl: String?
    var duration: TimeInterval?
    var adTrackingEvents: OMIDAdTrackingEvents?
}

class InLineAdData: AdData {
    var creatives: [Any]? = []
}

class WrapperAdData: AdData {
    var VASTUrl: String?
    var vastResponse: VASTResponse?
}


// impression
struct OMIDImpression {
    var impressionUrl: String? = "none"
}

// Verification
class OmidVerification: NSObject {
    var javaScriptResource: String?
    var verificationParameters: String?
    var vendorKey: String? = "none"
    
    override func isEqual(_ other: Any?) -> Bool {
        if (other == nil) || (type(of: self) != type(of: other)) {
            return false
        }
        if other as? NSObject == self {
            return true
        }
        let ver = other as? OmidVerification
        return (verificationParameters == ver?.verificationParameters) && (javaScriptResource == ver?.javaScriptResource) && (vendorKey == ver?.vendorKey)
    }
    
    override var hash: Int {
        return vendorKey!.hash ^ javaScriptResource!.hash ^ verificationParameters!.hash
    }
//    override class func hash() -> Int {
//        return vendorKey?.hash() ??  ^ javaScriptResource?.hash() ^ verificationParameters?.hash()
//    }
}

class OmidAdVerification: NSObject {
    var omidVerifications: [OmidVerification]? = []

    func merge(_ adVerification: OmidAdVerification?) {
        if let omidVerifications = adVerification?.omidVerifications {
            for (idx, obj) in omidVerifications.enumerated() {
                if omidVerifications.contains(obj) {
                    adVerification?.omidVerifications?[idx] = obj
                } else {
                    adVerification?.omidVerifications?.append(obj)
                }
            }
        }
    }
}
