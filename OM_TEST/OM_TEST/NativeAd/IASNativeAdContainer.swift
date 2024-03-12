//
//  IASNativeAdContainer.swift
//  IASOMID_SDK
//
//  Created by Archana Deshmukh on 01/08/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation
import UIKit
/**
 - IASNativeAdContainer class extends UIView
 - functions for returning UIView and set adView
 */
public class IASNativeAdContainer: UIView {
    private var _adView: UIView?

    func adView() -> UIView? {
        return _adView
    }

    func setAdView(_ adView: UIView?) {
        if let _adView = _adView {
            _adView.removeFromSuperview()
        }
        _adView = adView
        _adView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_adView!)
        ias_addConstraints(toItem: _adView)
    }
}
