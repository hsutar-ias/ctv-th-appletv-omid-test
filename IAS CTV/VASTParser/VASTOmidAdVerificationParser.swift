//
//  VASTOmidAdVerificationParser.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 12/05/21.
//

import Foundation


class VASTOmidAdVerificationParser: VASTBaseParser {
    lazy private(set) var omidAdVerification = OmidAdVerification()
    
    var vendorKey: String?
    
    override func didStartElement(_ elementName: String?, attributes attributeDict: [String : String]?) {
        super.didStartElement(elementName, attributes: attributeDict)
        if elementName == "Verification" {
            vendorKey = attributeDict?["vendor"]
        }
    }

    override func createParser(forElement elementName: String?) -> VASTNodeParser? {
        if elementName == "Verification" {
            return VASTOmidVerificationParser()
        }
        return nil
    }
    
    override func didEndElement(_ elementName: String?, value: String?, parser: VASTNodeParser?) {
        let verification = (parser as? VASTOmidVerificationParser)?.omidVerification
        verification?.vendorKey = vendorKey
        if let verification = verification {
            if !(omidAdVerification.omidVerifications?.contains(verification) ?? false) && ((vendorKey?.contains("IAS")) ?? false || (vendorKey?.contains("integralads") ?? false)) {
                omidAdVerification.omidVerifications?.append(verification)
            }
        }
    }
    
}
