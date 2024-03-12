//
//  VASTResponse.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 12/05/21.
//

import Foundation

class VASTResponse: NSObject{
    var ads: [Any]?
    var needLoadWrapper: Bool {
        return wrapperAdData() != nil
    }
    var wrapperVASTUrl: String? {
        return wrapperAdData()?.VASTUrl
    }

    func setWrapperVASTResponse(_ response: VASTResponse?) {
        wrapperAdData()?.vastResponse = response;
    }
    
    func wrapperAdData() -> WrapperAdData? {
        if ads?.count == 0 {
            return nil
        }
        let adData = (ads?[0] as? Ad)?.adData
        if !(adData is WrapperAdData) {
            return nil
        }
        let wrapperAdData = adData as? WrapperAdData
        return (wrapperAdData?.vastResponse != nil) ? wrapperAdData?.vastResponse?.wrapperAdData() : wrapperAdData
    }
}
