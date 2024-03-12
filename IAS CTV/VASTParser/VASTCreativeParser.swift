//
//  VASTCreativeParser.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 13/05/21.
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
