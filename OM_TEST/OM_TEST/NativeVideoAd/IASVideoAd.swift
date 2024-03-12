//
//  IASVideoAd.swift
//  IAS_OMSDK
//
//  Created by Archana Deshmukh on 02/08/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation
/**
- IASVideoAd class extends IASBaseVideoAd and implements it's functions
*/
public class IASVideoAd: IASBaseVideoAd {
  public var adContainer: IASNativeAdContainer?

   public func view() -> UIView? {
    if !(adContainer != nil) {
            adContainer = IASNativeAdContainer()
        }
        return adContainer
    }

    public override func prepare(){
        adContainer?.setAdView(player()?.bannerView())
    }
    
    public func viewWillAppear() {
        player()!.resume()
    }

    public func viewWillDisappear() {
        player()!.pause()
    }

    deinit {
        cleanup()
    }
}
