//
//  IASCreativesURLUtil.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 04/08/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
/**
Class used for setting a creative url
*/
public class IASCreativesURLUtil: NSObject
{
    var address: String?

    override init() {
        address = ""
    }
    public static let  shared = IASCreativesURLUtil()
    
    public func setURL(_ url: String?) {
        IASCreativesURLUtil.shared.address = url
    }
}
