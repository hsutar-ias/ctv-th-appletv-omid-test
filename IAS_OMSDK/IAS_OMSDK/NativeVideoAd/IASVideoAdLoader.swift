//
//  IASVideoAdLoader.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
typealias CompletionHandler = (VASTResponse?) -> Void
typealias ErrorHandler = (Error?) -> Void

public class IASVideoAdLoader: NSObject {
    private var rootResponse: VASTResponse?
    
    var omidVerificationScriptResource: [OMIDVerificationScriptResource]?
    private var completionHandler: CompletionHandler?
    private var errorHandler: ErrorHandler?
    
    public func loadAdWithUrl(with url: URL?, completionHandler: @escaping (_ response: VASTResponse?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        self.completionHandler = completionHandler
        self.errorHandler = errorHandler
        self.loadUrl(url)
    }
    
    func loadUrl(_ url: URL?) {
        weak var weakSelf = self
        IASNetworkHelper.loadNativeVideoAd(with: url, completionHandler: { response in
            weakSelf?.onLoadVASTResponse(response)
        }, errorHandler: { error in
            weakSelf?.onError(error)
        })
    }
    
    func downloadVideo(_ url: URL?, completionHandler: @escaping (_ response: String?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        IASNetworkHelper.downloadNativeVideoAd(with: url, completionHandler: { response in
            completionHandler(response)
        }, errorHandler: { error in
            errorHandler(error)
        })
    }
    
    func onLoadVASTResponse(_ response: VASTResponse?) {
        handle(response)
        if !(rootResponse != nil) {
            rootResponse = response
        } else {
            rootResponse?.setWrapperVASTResponse(response)
        }
        if rootResponse!.needLoadWrapper() {
            let url = URL(string: response!.wrapperVASTUrl() ?? "")
            self.loadUrl(url)
        } else if completionHandler != nil {
            completionHandler!(rootResponse)
        }
    }
    
    func onError(_ error: Error?) {
        if (errorHandler != nil) {
            errorHandler!(error)
        }
    }
    
    func handle(_ response: VASTResponse?) {
        if response?.ads?.count == 0 {
            return
        }
        let ad = response?.ads![0] as? Ad
        let adVerification = OmidAdVerification()
        for (_, obj) in ((ad?.adData!.omidAdVerifications)!.enumerated()) {
            adVerification.merge(obj)
        }
        handle(adVerification)
    }
    
    func handle(_ adVerification: OmidAdVerification?) {
        omidVerificationScriptResource = [OMIDVerificationScriptResource]() 
        for (_, verification) in (adVerification?.omidVerifications!.enumerated())! {
            if (verification.javaScriptResource != nil) {
                
                if (verification.vendorKey != nil) && (verification.verificationParameters != nil) {
                    let resource = OMIDVerificationScriptResource(url: URL(string: verification.javaScriptResource!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!, vendorKey: verification.vendorKey!, parameters: verification.verificationParameters!)
                    omidVerificationScriptResource?.append(resource!)
                }
                else{
                    if let urlVerificationString = verification.javaScriptResource?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
                        if let urlverification = URL(string: urlVerificationString) {
                            if let resource = OMIDVerificationScriptResource(url: urlverification) {
                                omidVerificationScriptResource?.append(resource)
                            }
                        }
                    }
                }
            }
        }
    }
}
