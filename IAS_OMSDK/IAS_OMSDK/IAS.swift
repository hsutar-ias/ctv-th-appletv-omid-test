//
//  IAS.swift
//  IASOMID_SDK
//
//  Created by Archana Deshmukh on 01/08/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation
/**
 - IAS used for provide OMIDSDK activation flag status, library version
 - Assigning IAS Server port number and creative url string
 */
public class IAS
{
    public class func setup() {
        OMIDSDK.shared.activate()
    }
    
    public class func provideServerPort(_ serverPort: Int) {
        IASServerPortConfig.shared.serverPort = serverPort
    }
    
    public class func libraryVersion() -> String? {
        return OMIDSDK.versionString()
    }
    
    public class func provideCreativesURL(_ url: String?) {
        IASCreativesURLUtil.shared.address = url
    }
}
