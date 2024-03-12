//
//  SinglePageAdViewController.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 18/07/23.
//

import Foundation
import UIKit
/**
 - SinglePageAdViewController class is represent view controller of Single Page Configuration screen
 */
class SinglePageAdViewController: BaseAdViewController {
    
    static let TIMER_PERIOD = 5
    static let TITLE_SIMPLE = "Simple"
    private var adSource: AdSource?
    private var hiddenAdSource: AdSource?
    private var timer: Timer?
    private var isLogViewLoaded : Bool = false
  
    @objc override func showAppLogs() {
   
    }
    
    private var scenarioTitle: String {
        get{
            return SinglePageAdViewController.TITLE_SIMPLE
        }
    }
    
    @IBOutlet weak var container: UIView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.modalPresentationStyle = .fullScreen
//        self.navigationItem.title = scenarioTitle
//        self.configureNavigationBar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        create()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !isLogViewLoaded {
            adSource?.viewWillDisappear()
            adSource?.finishSession()
        }
        else{
            isLogViewLoaded = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adSource?.viewWillAppear()
    }
    
    override func adVisibilityString() -> String? {
        //        return visibilityString(withAdSource: adSource)
        return ""
    }
    
    override func clear() {
        adSource?.adView?.removeFromSuperview()
        adSource?.cleanup()
        adSource = nil
        super.clear()
    }
    /**
     
     */
    override func create() {
        adSource = AdFactory.sharedFactory.getAdSource(with: self)
        container.addSubview((adSource?.adView)!)
        setLayoutConstraintsForAdView(adSource?.adView, container: container)
        
    }
   
}
