//
//  VASTAdParser.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation

// MARK: VASTNodeParser
protocol VASTNodeParser: NSObjectProtocol {
    func didStartElement(_ elementName: String?, attributes attributeDict: [String : String]?)
    func didEndElement(_ elementName: String?, value: String?)
    func foundCDATA(_ CDATABlockString: String?)
}

// MARK: VASTBaseParser
class VASTBaseParser: NSObject, VASTNodeParser {
    var currentElement: String?
    var currentParser: VASTNodeParser?
    func didStartElement(_ elementName: String?, attributes attributeDict: [String : String]?) {
        if (currentParser != nil) {
            currentParser?.didStartElement(elementName, attributes: attributeDict)
        } else {
            currentParser = createParser(forElement: elementName)
            currentElement = (currentParser != nil) ? elementName : nil
        }
    }
    
    func didEndElement(_ elementName: String?, value: String?) {
        if currentElement == elementName {
            didEndElement(elementName, value: value, parser: currentParser)
            currentParser = nil
            currentElement = nil
        } else {
            currentParser?.didEndElement(elementName, value: value)
        }
    }
    
    func foundCDATA(_ CDATABlockString: String?) {
        currentParser?.foundCDATA(CDATABlockString)
    }
    
    open func createParser(forElement elementName: String?) -> VASTNodeParser? {
        return nil
    }

    open func didEndElement(_ elementName: String?, value: String?, parser: VASTNodeParser?) {

    }
}

// MARK: VASTAdParser
class VASTAdParser: VASTBaseParser {
    private(set) var ad: Ad? = Ad()
    
    override func createParser(forElement elementName: String?) -> VASTNodeParser? {
        if elementName == "InLine" {
            return VASTInLineParser()
        } else if elementName == "Wrapper" {
            return VASTWrapperParser()
        }
        return nil
    }

    override func didEndElement(_ elementName: String?, value: String?, parser: VASTNodeParser?) {
        ad?.adData = (parser as? VASTAdDataParser)?.adData
    }
}
