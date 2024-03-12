//
//  IASUserAgent.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 18/05/22.
//  Copyright © 2022 Akshay Patil. All rights reserved.
//
import Foundation

public class IASUserAgent {
    public var userAgentName: String = ""
    
    internal static let userAgent = IASUserAgent()
    
    public static func setIASUserAgent(_ userAgentName: String) {
        userAgent.userAgentName = userAgentName
    }
}

