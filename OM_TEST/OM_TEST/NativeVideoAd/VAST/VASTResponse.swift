//
//  VASTResponse.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class Ad: NSObject {
    var adData: AdData?
}

public class VASTResponse: NSObject {
    
    var ads: [AnyHashable]?

   func needLoadWrapper() -> Bool {
        return wrapperAdData() != nil
    }

    func wrapperVASTUrl() -> String? {
        return wrapperAdData()?.vastUrl
    }

    func setWrapperVASTResponse(_ response: VASTResponse?) {   
        wrapperAdData()?.vastResponse = response
    }
    
    func wrapperAdData() -> WrapperAdData? {
        if ads!.count == 0 {
            return nil
        }
        let adData = (ads![0] as? Ad)?.adData
        if !(adData is WrapperAdData) {
            return nil
        }
        let wrapperAdData = adData as? WrapperAdData
        if ((wrapperAdData?.vastResponse) != nil) {
            return wrapperAdData?.vastResponse?.wrapperAdData()
        }
        else{
            return wrapperAdData
        }
    }
}
