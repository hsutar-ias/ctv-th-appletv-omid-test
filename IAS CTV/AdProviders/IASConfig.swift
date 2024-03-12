//
//  IASConfig.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 02/08/23.
//

import Foundation
struct IASConfig {
    static let DEFAULT_HOST = "http://mobile-static.adsafeprotected.com"
    static let DEFAULT_CREATIVES_PATH = "/static/creative/omid-v1/certification-v013"
//"/static/creative/omid-v1/certification-%%CREATIVES_VERSION%%"
    static let DEFAULT_DYNAMIC_AD_URL = "/html-display/index%%OMID_PLACEMENT_ID%%.html"
    static let DEFAULT_STATIC_AD_URL = "/html-display/index1.html"
    static let DEFAULT_DYNAMIC_VIDEO_AD_URL = "/vast/vast%%VAST_VERSION%%-placement%%OMID_PLACEMENT_ID%%.xml"
    static let DEFAULT_STATIC_VIDEO_AD_URL = "/vast/vast%%VAST_VERSION%%-placement1.xml"
    static let DEFAULT_STATIC_HTML_VIDEO_AD_URL = "/html-video/index1.html"
    static let DEFAULT_DYNAMIC_HTML_VIDEO_AD_URL = "/html-video/index%%OMID_PLACEMENT_ID%%.html"
    static let DEFAULT_STATIC_HTML_AUDIO_AD_URL = "/html-audio/index1.html"
    static let DEFAULT_DYNAMIC_HTML_AUDIO_AD_URL = "/html-audio/index%%OMID_PLACEMENT_ID%%.html"
    static let DEFAULT_DYNAMIC_DISPLAY_300_250_AD_URL = "/native-display/300x250-%%OMID_PLACEMENT_ID%%.json"
    static let DEFAULT_STATIC_DISPLAY_300_250_AD_URL = "/native-display/300x250-1.json"
    static let DEFAULT_DYNAMIC_DISPLAY_2000_2000_AD_URL = "/native-display/2000x2000-%%OMID_PLACEMENT_ID%%.json"
    static let DEFAULT_STATIC_DISPLAY_2000_2000_AD_URL = "/native-display/2000x2000-1.json"
    static let URL_ID_TEMPLATE = "%%OMID_PLACEMENT_ID%%"
}
