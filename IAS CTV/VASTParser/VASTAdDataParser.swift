//
//  VASRAdDataParser.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 12/05/21.
//

import Foundation

class VASTAdDataParser: VASTBaseParser {
    open var adData: AdData? {
        return nil
    }

    override func createParser(forElement elementName: String?) -> VASTNodeParser? {
        if elementName == "AdVerifications" {
            return VASTOmidAdVerificationParser()
        }
        return nil
    }
    
    override func didEndElement(_ elementName: String?, value: String?, parser: VASTNodeParser?) {
        if elementName == "AdVerifications" {
            if let omidAdVerification = (parser as? VASTOmidAdVerificationParser)?.omidAdVerification {
                adData?.omidAdVerifications?.append(omidAdVerification)
            }
        }
    }
}
