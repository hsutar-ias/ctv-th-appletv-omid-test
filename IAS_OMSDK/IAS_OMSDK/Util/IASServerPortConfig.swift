//
//  IASServerPortConfig.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 04/08/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
/**
 Class used for configure server port
 */
public class IASServerPortConfig: NSObject {
    var serverPort = 0
    
    override init() {
        super.init()
        serverPort = 80
    }
    public static let  shared = IASServerPortConfig()
  
}
