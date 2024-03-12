//
//  IASNetworkHelper.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 13/05/21.
//

import Foundation


class IASNetworkHelper {
    
    class func loadData(with url: URL?, completionHandler: @escaping (_ data: Data?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let completionHandler = completionHandler
        let errorHandler = errorHandler
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
        let task = URLSession.ias_mainSession()?.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                errorHandler(error)
            } else {
                completionHandler(data)
            }
        })
        task?.resume()
    }
    
    class func loadNativeVideoAd(with url: URL?, completionHandler: @escaping (_ response: VASTResponse?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let completionHandler = completionHandler
        loadData(with: url, completionHandler: { data in
            var vast: String? = nil
            if let data = data {
                vast = String(data: data, encoding: .utf8)
            }
            let parser = IASVASTParser()
            parser.parseVAST(vast, completionHandler: { response in
                completionHandler(response)
            })
        }, errorHandler: errorHandler)
    }
    
    class func loadNativeAudioAd(with url: URL?, completionHandler: @escaping (_ response: VASTResponse?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        
        let completionHandler = completionHandler
        
        loadData(with: url, completionHandler: { data in
            
            var vast: String? = nil
            
            if let data = data {
                vast = String(data: data, encoding: .utf8)
            }
            
            let parser = IASVASTParser()
            
            parser.parseVAST(vast, completionHandler: { response in
                completionHandler(response)
            })
            
        }, errorHandler: errorHandler)
    }
    
}

extension URLSession {
    static var session: URLSession? = {
        var session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        return session
    }()

    class func ias_mainSession() -> URLSession? {
        // `dispatch_once()` call was converted to a static variable initializer
        return session

    }
}
