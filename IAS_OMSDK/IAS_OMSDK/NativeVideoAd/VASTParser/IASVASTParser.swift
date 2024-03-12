//
//  IASVASTParser.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation

class IASVASTParser: NSObject, XMLParserDelegate {
    typealias ParserCompletionHandler = (VASTResponse?) -> Void
    private var buffer: String?
    private var responseParser: VASTResponseParser?
    private var completionHandler: ParserCompletionHandler?
    
    func parseVAST(_ xml: String?, completionHandler: @escaping (_ result: VASTResponse?) -> Void) {
        self.completionHandler = completionHandler
        var parser: XMLParser? = nil
        if let data = xml?.data(using: .utf8) {
            parser = XMLParser(data: data)
        }
        parser?.delegate = self
        responseParser = VASTResponseParser()
        parser?.parse()
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        let response = responseParser?.response()
        if completionHandler != nil {
            completionHandler?(response)
        }
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        responseParser?.didStartElement(elementName, attributes: attributeDict)
        buffer = ""
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        responseParser?.didEndElement(elementName, value: buffer)
        buffer = nil
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        buffer? += string
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        var temp = String(data: CDATABlock, encoding: .utf8)
        temp = temp?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        responseParser?.foundCDATA(temp)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred")
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("validationErrorOccurred")
    }
}
