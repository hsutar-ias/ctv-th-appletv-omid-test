//
//  IASNativeDisplayAdInfo.swift
//  IAS_OMSDK
//
//  Created by Archana Deshmukh on 03/08/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation
let KEY_CREATIVE_URL = "imageUrl"
let KEY_CLICK_URL = "clickUrl"
let KEY_VERIFICATION_SCRIPT_RESOURCES = "verificationScriptResources"
let KEY_API_FRAMEWORK = "apiFramework"
let KEY_JAVASCRIPT_RESOURCE = "javaScriptResource"
let KEY_VENDOR_KEY = "vendorKey"
let KEY_VERIFICATION_PARAMETERS = "verificationParameters"
let KEY_SERVER_PORT = "serverPort"
let KEY_OMID = "OMID"

/**
 - IASNativeDisplayAdInfo class having a functions as info, getVerificationScriptResources , updateVerificationScriptResource and getVerificationScriptResourcesString for handling verification script
 */
class IASNativeDisplayAdInfo: NSObject {
    var creativeUrl: String?
    var clickUrl: String?
    var verificationScriptResources: [OMIDVerificationScriptResource]?

    class func info(withJson json: [AnyHashable : Any]?) -> IASNativeDisplayAdInfo?
    {
        let info = IASNativeDisplayAdInfo()
        info.creativeUrl = json![KEY_CREATIVE_URL] as? String
        if !(info.creativeUrl != nil) {
            return nil
        }
        info.clickUrl = json![KEY_CLICK_URL] as? String
        let verificationScriptResourcesJSON = json?["verificationScriptResources"]
        info.verificationScriptResources = self.getVerificationScriptResources(from: verificationScriptResourcesJSON as? [Any])
        return info
    }
    
    class func getVerificationScriptResources(from resourcesJSON: [Any]?) -> [OMIDVerificationScriptResource]? {
        var result: [OMIDVerificationScriptResource]? = []
        for (_, obj) in resourcesJSON!.enumerated() {
            let resource = obj as? [String : Any]
            if let resource = resource {
                let apiFramework = resource[KEY_API_FRAMEWORK] as? String
                if apiFramework != nil && (apiFramework == KEY_OMID) {
                    let url = URL(string: ((obj as? [AnyHashable : Any])?[KEY_JAVASCRIPT_RESOURCE] as? String) ?? "")
                    let vendorKey = (obj as? [AnyHashable : Any])?[KEY_VENDOR_KEY] as? String
                    let parameters = (obj as? [AnyHashable : Any])?[KEY_VERIFICATION_PARAMETERS] as? String
                    if (url != nil) {
                        if (vendorKey != nil) && (parameters != nil) {
                            let scriptResource = OMIDVerificationScriptResource(url: url!, vendorKey: vendorKey!, parameters: parameters!)
                            result!.append(scriptResource!)
                        } else {
                            let scriptResource = OMIDVerificationScriptResource(url: url!)
                            result!.append(scriptResource!)
                        }
                    }
                }
            }
        }
        
        return result
    }
    
    class func updateVerificationScriptResource(_ resource: OMIDVerificationScriptResource?) -> OMIDVerificationScriptResource? {
        var result = resource
        if (resource!.vendorKey != nil) && (resource?.vendorKey == "IAS") {
            let serverPort = Int(IASServerPortConfig.shared.serverPort)
            if serverPort != 80 {
                var params = resource?.parameters
                if (params != nil) {
                    params = params!.replacingCharacters(in: params!.range(of: "}")!, with: String(format: ", \"serverPort\":\"%lu\"}", serverPort))
                    result = OMIDVerificationScriptResource(url: resource!.url, vendorKey: (resource?.vendorKey!)!, parameters: params!)
                }
            }
        }
        return result
    }
    
    class func getVerificationScriptResourcesString(from resources: [OMIDVerificationScriptResource]?) -> String? {
        var arr: [[AnyHashable : Any]]? = []
        (resources as NSArray?)?.enumerateObjects({ obj, idx, stop in
            let resource = self.updateVerificationScriptResource(obj as? OMIDVerificationScriptResource)
            var dict: [AnyHashable : Any] = [:]
            dict[KEY_API_FRAMEWORK] = KEY_OMID
            if (resource!.vendorKey != nil) {
                dict[KEY_VENDOR_KEY] = resource?.vendorKey
            }
            if ((resource?.url) != nil) {
                dict[KEY_JAVASCRIPT_RESOURCE] = resource!.url.absoluteString
            }
            if (resource!.parameters != nil) {
                dict[KEY_VERIFICATION_PARAMETERS] = resource?.parameters
            }
            arr?.append(dict)
        })
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(
                withJSONObject: arr!,
                options: .prettyPrinted)
        } catch {
        }
        if let jsonData = jsonData {
            return String(data: jsonData, encoding: .utf8)
        } else {
            return nil
        }
    }
}
