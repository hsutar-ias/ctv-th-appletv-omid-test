//
//  VASTResponseParser.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class VASTResponseParser: VASTBaseParser {
    private var mResponse: VASTResponse?
    
    func response() -> VASTResponse? {
        if (mResponse == nil) {
            mResponse = VASTResponse()
            mResponse?.ads = [AnyHashable]() 
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
