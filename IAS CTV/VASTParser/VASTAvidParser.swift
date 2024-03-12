//
//  VASTAvidParser.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 13/05/21.
//

import Foundation

class VASTAvidParser: VASTBaseParser {
    override func createParser(forElement elementName: String?) -> VASTNodeParser? {
        if elementName == "AdVerifications" {
            return VASTOmidAdVerificationParser()
        }
        return nil
    }
    
    override func didEndElement(_ elementName: String?, value: String?, parser: VASTNodeParser?) {
        let omidAdverification = (parser as? VASTOmidAdVerificationParser)?.omidAdVerification
        omidAdverification?.omidVerifications?.removeLast()
    }
}
