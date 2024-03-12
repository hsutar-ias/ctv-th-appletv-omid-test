//
//  IASNetwokHelper.swift
//  IASOMID_SDK
//
//  Created by Archana Deshmukh on 01/08/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation

let ERROR_DOMAIN = "com.integralds"
let INVALID_RESPONSE_ERROR_CODE = -1
/**
- IASNetworkHelper class used for loading a video data, native display ad data and download a video ad
*/
public class IASNetworkHelper: NSObject
{
    class func loadData(with url: URL?, completionHandler: @escaping (_ data: Data?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let completionHandler = completionHandler
        let errorHandler = errorHandler
        if let url = url{
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
            let urlSession = URLSession.ias_mainSession()
            let task = urlSession!.dataTask(with: request) { data, response, error in
                if error != nil {
                    errorHandler(error)
                } else {
                    completionHandler(data)
                }
            }
            task.resume()
        }
    }
    
    class func loadNativeVideoAd(with url: URL?, completionHandler: @escaping (_ response: VASTResponse?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let completionHandler = completionHandler
        self.loadData(with: url, completionHandler: { data in
            var vast: String? = nil
            if let data = data {
                vast = String(data: data, encoding: .utf8)
            }
            let parser = IASVASTParser()
            parser.parseVAST(vast) { response in
                if completionHandler != nil {
                    completionHandler(response)
                }
            }
        }, errorHandler: errorHandler)
    }
    
//    class func loadNativeDisplayAd(with url: URL?, completionHandler: @escaping (_ info: IASNativeDisplayAdInfo?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
//    {
//        IASNetworkHelper.loadData(with: url, completionHandler: {data in
//            var json: [AnyHashable : Any]? = nil
//            do {
//                if let data = data {
//                    json = try (JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable : Any])
//                }
//            } catch {
//            }
////            let info = IASNativeDisplayAdInfo.info(withJson: json)
////            if info != nil {
////                if completionHandler != nil {
////                    completionHandler(info)
////                }
////            }
////            else if errorHandler != nil {
////                errorHandler(NSError(domain: ERROR_DOMAIN, code: INVALID_RESPONSE_ERROR_CODE, userInfo: nil))
////            }
//        }, errorHandler: errorHandler)
//    }
//
    class func downloadNativeVideoAd(with url: URL?, completionHandler: @escaping (_ response: String?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
        let fileName = url!.lastPathComponent
        let downloadTask = (URLSession.ias_mainSession())!.downloadTask(with: request) { location, response, error in
            if let error = error {
                errorHandler(error)
                return
            }
            let errorWhileFileMove: Error? = nil
            
            let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            let cacheFilePath = paths.first
            
            let cacheFilePathString = cacheFilePath?.appendingPathComponent(fileName).path
            let fileUrl = URL(string: "file://\(cacheFilePathString!)")
            do {
                try FileManager.default.removeItem(at: fileUrl!)
            } catch let errorIfRemoveItem {
                print("errorL \(errorIfRemoveItem)")
            }
            
            var status = false
            do {
                try FileManager.default.copyItem(at: location!, to: fileUrl!)
                status = true
            } catch let errorWhileFileMove {
                print("errorL \(errorWhileFileMove)")
            }
            if status == false {
                print("errorL \(String(describing: errorWhileFileMove))")
                errorHandler(errorWhileFileMove)
                return
            }
            
            completionHandler(cacheFilePathString)
        }
        downloadTask.resume()
    }
}
