//
//  IASVASTParser.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 12/05/21.
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
        requstJavaScriptResource(data: (response)!)
    }
    
    private func requstJavaScriptResource(data: VASTResponse){
  
        let ad = data.ads?[0] as? Ad
//        let adVerification = OmidAdVerification()
        if (ad?.adData?.omidAdVerifications!.count)! > 0{
            
            let verification =  ad?.adData?.omidAdVerifications?[0].omidVerifications
            
             guard let impressions =  verification else {
                     return
             }

             for val in impressions{
                 let url = URL(string: val.javaScriptResource!) ?? nil
                 loadURL(url!)
             }
        }
       
        
    }
    private func loadURL(_ url: URL) {
        IASNetworkHelper.loadData(with: url) { (data) in
            
        } errorHandler: { (error) in
            
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
