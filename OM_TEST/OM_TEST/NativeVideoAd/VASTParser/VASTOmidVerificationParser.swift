//
//  VASTOmidVerificationParser.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class VASTOmidVerificationParser: NSObject, VASTNodeParser {
    lazy private(set) var omidVerification = OmidVerification()
    var isJavaScriptResource = false
    var isVerificationParameters = false
    
    func didStartElement(_ elementName: String?, attributes attributeDict: [String : String]?) {
        isJavaScriptResource = (elementName == "JavaScriptResource")
        isVerificationParameters = (elementName == "VerificationParameters")
    }
    
    func didEndElement(_ elementName: String?, value: String?) {
        isJavaScriptResource = false
        isVerificationParameters = false
    }
    
    func foundCDATA(_ CDATABlockString: String?) {
        if isJavaScriptResource {
            omidVerification.javaScriptResource = CDATABlockString
        }
        if isVerificationParameters {
            omidVerification.verificationParameters = CDATABlockString
        }
    }
}
