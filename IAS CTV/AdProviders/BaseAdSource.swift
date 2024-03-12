//
//  BaseAdSource.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 02/08/23.
//

import Foundation
import UIKit

/**
 - Extend AdSource protocol and implement its functions
 - Used to register and unregister webview ,create a adView
 */
public class BaseAdSource<T : UIView>: NSObject, AdSource {
    var adVisibility: String?
    

    private var localAdView : T?
    internal var shouldBeHidden = false
    
    var adView: UIView? {
          get {
              if (localAdView == nil) {
                  localAdView = self.createAdView() as? T
                  localAdView?.translatesAutoresizingMaskIntoConstraints = false
//                self.detectWebView()
              }
              return localAdView
          }
          set {
              localAdView = newValue as? T
          }
    }
    
//    var adVisibility: String? {
//        return ((webViewHolder != nil) && webViewHolder!.visibility >= 0) ? String(format: "%ld%@", Int(webViewHolder!.visibility), "%") : "-"
//    }
    var index: Int = 0
    
    weak var controller: UIViewController?
    required init(controller: UIViewController?) {
        super.init()
        self.controller = controller
        shouldBeHidden = false
//        NotificationCenter.default.addObserver(self, selector: #selector(BaseAdSource.infoViewControllerWillAppear), name: NSNotification.Name(rawValue: INFO_WILL_APPEAR_NOTIFICATION), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(BaseAdSource.infoViewControllerWillDisappear), name: NSNotification.Name(rawValue: INFO_WILL_DISAPPEAR_NOTIFICATION), object: nil)
    }
    
//    var adWebView : UIView? {
//        return webViewHolder?.webView
//    }
//
//    func detectWebView() {
//        let webView = self.findWebView()
//        if let webView = webView {
//            self.registerWebView(webView: webView)
//        }
//    }
    
//    func findWebView() -> UIView? {
//        return AdUtil.webView(fromAdView: adView)!
//    }
//
//    @objc func tryDetectWebView() {
//        detectWebView()
//        if adWebView != nil {
//            perform(#selector(BaseAdSource.tryDetectWebView), with: nil, afterDelay: 0.1)
//        }
//    }
    
    func findTrackingWebView(_ view: UIView?) -> UIView? {
        let prefix = Config.sharedConfig.sdkProvider.omidNamespace
        let name = "\(prefix!)_OmidAdSessionManager"
        let _OmidAdSessionManager: AnyClass? = NSClassFromString(name)
        if _OmidAdSessionManager != nil {
//            return _OmidAdSessionManager.perform(NSSelectorFromString("webViewForView:"), with: view)
        }
        return nil
    }
    
    func createAdView() -> UIView? {
        return nil
    }
    
    func supportOmid() -> Bool {
        let prefix = Config.sharedConfig.sdkProvider.omidNamespace
        let name = "\(prefix!)_OmidAdSessionManager"
        return (NSClassFromString(name) != nil)
    }
//    func registerWebView(webView: UIView?) {
//        if (webViewHolder?.webView == webView) {
//            return
//        }
//        if webView is WKWebView {
//            webViewHolder = THWKWebViewHolder()
//        } else {
//            webViewHolder = nil
//        }
//        webViewHolder?.webView = webView
//        if !Config.sharedConfig.sdkProvider.supportWebServerLogging() {
//            webViewHolder?.configure()
//        }
//        if shouldInjectTestHarnessJs() {
//            injectTestHarnessJs()
//        }
//    }
    
    func shouldInjectTestHarnessJs() -> Bool {
        return true;
    }
    
    public func injectTestHarnessJs(){
        if supportOmid(){
//            webViewHolder?.registerViewabilityListener()
        }
    }
    
//    func unregisterWebView() {
//        webViewHolder?.cleanup()
//        webViewHolder = nil
//    }
    
    func cleanup() {
//        self.unregisterWebView()
    }
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func finishSession() {
        
    }
    @objc func infoViewControllerWillAppear() {
        
    }
    
    @objc func infoViewControllerWillDisappear(){
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
