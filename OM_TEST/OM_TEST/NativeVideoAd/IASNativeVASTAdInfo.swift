//
//  IASNativeVASTAdInfo.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 09/03/22.
//  Copyright © 2022 Akshay Patil. All rights reserved.
//

import Foundation

class IASNativeVASTAdInfo: NSObject {
    required override init() {
        super.init()
    }
    
    open func mapInfo(with adData: InLineAdData?) {
    }
    
    class func info<T: IASNativeVASTAdInfo>(with response: VASTResponse?) -> T? {
        let info: T? = T()
        self.setupInfo(info, with: response)
        return info
    }
    
    class func setupInfo<T: IASNativeVASTAdInfo>(_ info: T?, with response: VASTResponse?) {
        if response?.ads?.count == 0 {
            return
        }
        let ad = response?.ads![0] as? Ad
        if ad?.adData is InLineAdData {
            self.setupInfo(info, with: ad?.adData as? InLineAdData)
        } else if ad?.adData is WrapperAdData {
            self.setupInfo(info, with: ad?.adData as? WrapperAdData)
        }
    }
    
    class func setupInfo<T: IASNativeVASTAdInfo>(_ info: T?, with adData: InLineAdData?) {
        info?.mapInfo(with: adData)
    }
    
    class func setupInfo<T: IASNativeVASTAdInfo>(_ info: T?, with adData: WrapperAdData?) {
        if ((adData?.vastResponse) != nil) {
            self.setupInfo(info, with: adData?.vastResponse)
        }
    }
}
