//
//  DispatchOnceForQurtileEvents.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 22/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
class DispatchOnceForQurtileEvents {
    var tokens: [String] = []
    
    func once(token: String, block: () -> Void)
    {
        if tokens.contains(token) {
            return
        }
        tokens.append(token)
        block()
    }
    
    func clearTokens() {
        tokens.removeAll()
    }
}
