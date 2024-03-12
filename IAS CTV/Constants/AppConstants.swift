//
//  AppConstants.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 10/07/23.
//

import Foundation
/**
 - Static String which is going to be used in app are declared here
 */

class AppConstants {

    // Labels String for AdConfiguration Screen
    struct Labels {
        static let nativeVideoAds = "Native Video Ads"
        static let nativeAudioAds = "Native Audio Ads"
        static let nativeDisplayAds = "Native Display Ads"
        static let iasPartner = "IAS"
        static let simpleScenario = "Simple"
        static let obstructionScenario = "Obstruction"
        static let defaultUserAgent = "Default"
        static let contentURLBtnTitle = "False"
        
        static let adsTypeNotSelected = "Ads Type not selected"
        static let partnerNotSelected = "Partner not selected"
        static let scenarioNotSelected = "Ad Scenario not selected"
        static let partnerVersionShouldFloat = "Partner Version should be float number"
        static let URLNotValid = "URL Not valid"
        static let vastShouldFloat = "VAST Version should be float number"
        static let userAgentNotSelected = "User Agent not selected"
        
        static let Default = "Default"
        static let emptyString = ""

        static let VAST42 = "4.2"
        static let VAST41 = "4.1"
        static let VAST40 = "4.0"
        static let VAST30 = "3.0"
        static let VAST20 = "2.0"

    }
    
    struct Boolean {
        static let trueString = "True"
        static let falseString = "False"
    }

}
