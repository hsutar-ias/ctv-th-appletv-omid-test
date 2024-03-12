//
//  VASTInLineParser.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation

class VASTInLineParser:  VASTAdDataParser{
    
    var mAdData: InLineAdData?
    
    override var adData: AdData? {
        if mAdData == nil {
            mAdData = InLineAdData()
            mAdData?.creatives = [Any]() as? [AnyHashable]
            mAdData?.omidAdVerifications = [OmidAdVerification]()
            mAdData?.omidImpressions = [OMIDImpression]()
        }
        return mAdData
    }
    
    override func createParser(forElement elementName: String?) -> VASTNodeParser? {
        if elementName == "Creative" {
            return VASTCreativeParser()
        }
        if elementName == "AVID" {
            return VASTAvidParser()
        }
        if elementName == "Impression" {
            return VASTImpressionParser()
        }
        return super.createParser(forElement: elementName)
    }
    
    override func didEndElement(_ elementName: String?, value: String?, parser: VASTNodeParser?) {
        if elementName == "Creative" {
            if let adCreative = (parser as? VASTCreativeParser)?.adCreative {
                (adData as? InLineAdData)?.creatives?.append(adCreative)
            }
        } else if elementName == "Impression" {
            if let impression = (parser as? VASTImpressionParser)?.impression {
                (adData as? InLineAdData)?.omidImpressions?.append(impression)
            }
        } else {
            super.didEndElement(elementName, value: value, parser: parser)
        }
    }
}
