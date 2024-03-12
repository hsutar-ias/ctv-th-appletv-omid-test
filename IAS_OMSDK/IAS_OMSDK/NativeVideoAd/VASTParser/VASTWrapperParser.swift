//
//  VASTWrapperParser.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation

class VASTWrapperParser: VASTAdDataParser {
    var mAdData : WrapperAdData?
    var isVASTAdTagURI = false
    
    override var adData: AdData? {
        if (mAdData == nil) {
            mAdData = WrapperAdData()
            mAdData?.omidAdVerifications = []
        }
        return mAdData
    }
    
    override func didStartElement(_ elementName: String?, attributes attributeDict: [String : String]?) {
        super.didStartElement(elementName, attributes: attributeDict)
        isVASTAdTagURI = (elementName == "VASTAdTagURI")
    }
    
    override func didEndElement(_ elementName: String?, value: String?) {
        super.didEndElement(elementName, value: value)
        isVASTAdTagURI = false
    }

    override func foundCDATA(_ CDATABlockString: String?) {
        super.foundCDATA(CDATABlockString)
        if isVASTAdTagURI {
            (adData as! WrapperAdData).vastUrl = CDATABlockString
        }
    }
}
