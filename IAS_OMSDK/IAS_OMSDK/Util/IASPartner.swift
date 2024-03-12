//
//  IASPartner.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 05/04/22.
//  Copyright © 2022 Akshay Patil. All rights reserved.
//

import Foundation

public class IASPartner {
    public var name: String = "IAS"
    public var version: String = "1.0"
    
    internal static let partner = IASPartner()
    
    public static func setIASPartner(_ partnerName: String, _ partnerVersion: String) {
        partner.name = partnerName
        partner.version = partnerVersion
    }
}
