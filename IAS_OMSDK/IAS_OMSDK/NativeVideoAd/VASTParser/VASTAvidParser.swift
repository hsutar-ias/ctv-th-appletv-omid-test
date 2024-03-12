//
//  v.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
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
