//
//  NSURLSession.swift
//  IASOMID_SDK
//
//  Created by Archana Deshmukh on 01/08/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation
extension URLSession {
    
    static var session: URLSession? = {
        let configuration = URLSessionConfiguration.default
        var session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        return session
    }()
    
    class func ias_mainSession() -> URLSession? {
        // `dispatch_once()` call was converted to a static variable initializer
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        return session
        
    }
}
