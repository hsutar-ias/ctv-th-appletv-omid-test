//
//  VASTResponseParser.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 12/05/21.
//

import Foundation

class VASTResponseParser: VASTBaseParser {
    private var mResponse: VASTResponse?
    
    func response() -> VASTResponse? {
        if (mResponse == nil) {
            mResponse = VASTResponse()
            mResponse?.ads = [Any]()
        }
        return mResponse
    }
     
    override func createParser(forElement elementName: String?) -> VASTNodeParser? {
        if elementName == "Ad" {
            return VASTAdParser()
        }
        return nil
    }
    
    override func didEndElement(_ elementName: String?, value: String?, parser: VASTNodeParser?) {
        if let ad = (parser as? VASTAdParser)?.ad {
            response()?.ads?.append(ad)
        }
    }
}
