//
//  VASTCreativeParser.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation

class VASTCreativeParser: VASTBaseParser {
    lazy var adCreative = AdCreative()
    
    override func createParser(forElement elementName: String?) -> VASTNodeParser? {
        if elementName == "Linear" {
            return VASTLinearParser()
        }
        return nil
    }

    override func didEndElement(_ elementName: String?, value: String?, parser: VASTNodeParser?) {
        adCreative.adData = (parser as? VASTAdMediaDataParser)?.adMediaData
    }
}
