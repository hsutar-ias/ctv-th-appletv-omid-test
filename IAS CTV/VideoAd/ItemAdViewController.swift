//
//  ItemAdViewController.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 18/07/23.
//

import Foundation
import UIKit
/**
 - ItemAdViewController class is used as a base class for Tab view controller and carousel view controller
 */
class ItemAdViewController: BaseAdViewController {
    var index = 0
    var hasAd: Bool {
        
//        return self.index < Config.sharedConfig.adBannerCount
        return true
    }
  
    private var adSource: AdSource?
    
    @IBOutlet var container: UIView!
    @IBOutlet weak var interstitialContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.create()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adSource?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        adSource?.viewWillDisappear()
    }
    
    override func create() {
        if (!self.hasAd || !self.isViewLoaded) {
            return
        }
        
        adSource = AdFactory.sharedFactory.getAdSource(with: self)
        adSource?.index = self.index + 1
        self.container.addSubview((adSource?.adView!)!)
//        self.setSize(Config.sharedConfig.adSize, toAdView: adSource?.adView, containerView: self.container)
        self.addConstraint(NSLayoutConstraint.Attribute.centerX, to: self.container, subview: adSource?.adView)
        self.addConstraint(NSLayoutConstraint.Attribute.top, to: self.container, subview: adSource?.adView)
    }
    
    func finishSession() {
        adSource?.finishSession()
    }
    
    override func updateVisibilityTitle()
    {
        
    }
    
    override func adVisibilityString() -> String? {
        return ((adSource) != nil) ? adSource?.adVisibility : "-"
    }
    
    override func clear() {
        adSource?.cleanup()
        adSource = nil
    }
}
