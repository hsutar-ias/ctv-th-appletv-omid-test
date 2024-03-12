//
//  Config.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 11/07/23.
//

import Foundation
import CoreGraphics

/**
 - Config class used to declare a Enum for Ad configuration screen
 - Declared fields with its tag value from ad configuration screen
 - Create functions for returing available option array value
 */
class Config {
    
    static let BANNER_TYPE_CHANGED = "BannerTypeChanged"
    
    enum ConfigOption: Int {
        case kAdScenario = 1,
        kAdSDK = 2,
        kAdBannerType = 3,
        kAdDimensions = 4,
        kAdCustomDimension = 5,
        kAdPosition = 6,
        kAdBannerUrl = 9,
        kAdBannerCount = 11,
        kAdContainerSize = 12,
        kAdClipToBounds = 13,
        kClutterAdCount = 10,
        kClutterViewCount = 14,
        kClutterViewDepth = 15,
        kObstructionType = 16,
        kIncludeTopObstruction = 17,
        kTopObstructionSize = 18,
        kIncludeBottomObstruction = 19,
        kBottomObstructionSize = 20,
        kIncludeLeftObstruction = 21,
        kLeftObstructionSize = 22,
        kIncludeRightObstruction = 23,
        kRightObstructionSize = 24,
        kWebViewType = 25,
        kAdCustomPosition = 30,
        kAdHiddenDimension = 31,
        kAdHiddenCustomDimennsion = 32,
        kAdHiddenPosition = 33,
        kAdHiddenCustomPosition = 34,
        kAdHiddenReason = 35,
        kAdContentUrl = 36
    }
    
    enum AdScenario: Int {
        case kSimpleScenario,
        kObstructionScenario
    }
    
    enum AdPosition: Int {
        case kTop,
        kMiddle,
        kBottom,
        kPositionCustom
    }
    
    enum AdDimension: Int {
        case kDim320_50,
        kDim300_50,
        kDim300_250,
        kDim1500_50,
        kDim50_1500,
        kDim1500_1500,
        kDim1_1,
        kDim300_1,
        kDim1_50,
        kDim2000_2000,
        kDimAuto,
        kDimCustom
    }
    enum AdDimensionField: Int {
        case kAdCustomWidth = 1,
        kAdCustomHeight = 2,
        kAdContainerWidth = 3,
        kAdContainerHeight = 4,
        kTopObstructionWidth = 5,
        kTopObstructionHeight = 6,
        kBottomObstructionWidth = 7,
        kBottomObstructionHeight = 8,
        kLeftObstructionWidth = 9,
        kLeftObstructionHeight = 10,
        kRightObstructionWidth = 11,
        kRightObstructionHeight = 12,
        kHiddenAdCustomWidth = 13,
        kHiddenAdCustomHeight = 14
    }
    
    enum AdPositionField: Int {
        case kAdPositionX = 1,
        kAdPositionY = 2
    }
    enum ObstructionType: Int {
        case kObstructionView
    }
    
    enum ObstructionSwitch: Int {
        case kTopObstructionSwitch = 1,
        kBottomObstructionSwitch,
        kLeftObstructionSwitch,
        kRightObstructionSwitch
    }
    
    enum VASTVersion: Int {
        case kVastVersion42,
        kVastVersion41,
        kVastVersion40,
        kVastVersion30,
        kVastVersion20
    }
    
    enum ContentURLSwitch : Int {
        case kContentURLSwitch = 5
    }
    
    enum AdPartnerName : Int {
        case kIASPartner
        case kCustomPartner
    }
    
    enum AdUserAgent : Int {
        case kDefaultUserAgent
        case kCustomUserAgent
    }
    
    static let AD_SCENARIO = 1
    static let AD_SDK = 2
    static let AD_BANNER_TYPE = 3
    static let AD_DIMENSIONS = 4
    static let AD_CUSTOM_DIMENSION = 5
    static let AD_POSITION = 6
    static let AD_BANNER_URL = 9
    static let AD_BANNER_COUNT = 11
    static let AD_CONTAINER_SIZE = 12
    static let AD_CLIP_TO_BOUNDS = 13
    static let AD_CLUTTER_AD_COUNT = 10
    static let AD_CLUTTER_VIEW_COUNT = 14
    static let AD_CLUTTER_VIEW_DEPTH = 15
    static let AD_OBSTRUCTION_TYPE = 16
    static let AD_INCLUDE_TOP_OBSTRUCTION = 17
    static let AD_TOP_OBSCTRUCTION_SIZE = 18
    static let AD_INCLUDE_BOTTOM_OBSTRUCTION = 19
    static let AD_BOTTOM_OBSCTRUCTION_SIZE = 20
    static let AD_INCLUDE_LEFT_OBSTRUCTION = 21
    static let AD_LEFT_OBSCTRUCTION_SIZE = 22
    static let AD_INCLUDE_RIGHT_OBSTRUCTION = 23
    static let AD_RIGHT_OBSCTRUCTION_SIZE = 24
    static let AD_WEB_VIEW_TYPE = 25
    static let AD_CUSTOM_POSITION = 30
    static let AD_HIDDEN_DIMENSION = 31
    static let AD_HIDDEN_CUSTOM_DIMENSION = 32
    static let AD_HIDDEN_POSITION = 33
    static let AD_HIDDEN_CUSTOM_POSITION = 34
    static let AD_HIDDEN_REASON = 35
    static let AD_VAST_VERSION = 36
    static let AD_INCLUDE_CONTENT_URL = 37
    static let AD_CONTENT_URL = 38
    static let AD_PARTNER_NAME = 39
    static let AD_CUSTOM_PARTNER_NAME = 40
    static let AD_AUDIO_MUTE = 41
    static let AD_AUDIO_AUTO_PLAY = 42
    static let AD_PARTNER_VERSION = 43
    
    static let AD_USER_AGENT = 44
    static let AD_CUSTOM_USER_AGENT = 45
    
    static let URL_ID_TEMPLATE = "%%OMID_PLACEMENT_ID%%"
    static let URL_CREATIVES_VERSION_TEMPLATE = "%%CREATIVES_VERSION%%"
    static let URL_VAST_VERSION_TEMPLATE = "%%VAST_VERSION%%"
    
    //Create singleton object of Config
    public static let sharedConfig = Config()
    
    public var sdkProvider : SDKProvider = DefaultSDKProvider()
    public var adBannerType: Int = 0 {
        didSet {
            self.adjustScenario()
            self.adjustDimension()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Config.BANNER_TYPE_CHANGED), object: nil)
        }
    }
    public var customAdSize : CGSize!
    public var adScenario: AdScenario = .kSimpleScenario
    public var adPosition: AdPosition = .kTop
    public var containerSize : CGSize = CGSize(width: 320, height: 50)
    public var vastVersion: VASTVersion = .kVastVersion42
    public var adBannerURL : String?
    public var obstructionType: ObstructionType = .kObstructionView
    public var includeTopObstruction = true
    public var includeBottomObstruction = false
    public var includeLeftObstruction = false
    public var includeRightObstruction = false
    public var resizeOffsetPosition : CGPoint = CGPoint(x: 0, y: 0)
    public var closeButtonPosition: Int = 0
    public var allowOffscreen = false
    
    public var customPartnerName: String?
    public var adPartnerName: AdPartnerName = .kIASPartner
    
    public var adPartnerVersion: String? = "1.0"
    public var isMuted = false
    
    public var customUserAgent: String?
    public var adUserAgent: AdUserAgent = .kDefaultUserAgent
    
    public var topObstructionSize : CGSize = CGSize(width: 50, height: 50)
    public var bottomObstructionSize : CGSize = CGSize(width: 50, height: 50)
    public var leftObstructionSize : CGSize = CGSize(width: 50, height: 50)
    public var rightObstructionSize : CGSize = CGSize(width: 50, height: 50)
    
    public var includeContentURL = false
    let options = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "data", ofType: "plist") ?? "")
    
//    public var adSize : CGSize {
//        return sdkProvider.adSize ?? CGSize(width: 0, height: 0)
//    }
//
    public var creativesVersion : String {
        return sdkProvider.creativesVersion()
    }

    public var libraryVersion : String{
        return sdkProvider.libraryVersion()
    }

    public var contentUrl = ContentUrl()
    
    /**
     - This function is called on click of Reset button
     - Used to reset the value of all variables
     */
    func reset() {
        adScenario = .kSimpleScenario
        adPosition = .kTop
        adDimension = .kDim320_50
        vastVersion = .kVastVersion42
        adBannerURL = nil
        adBannerType = 0
        obstructionType = .kObstructionView
        includeTopObstruction = true
        includeBottomObstruction = false
        includeLeftObstruction = false
        includeRightObstruction = false
        topObstructionSize = CGSize(width: 50, height: 50)
        bottomObstructionSize = CGSize(width: 50, height: 50)
        leftObstructionSize = CGSize(width: 50, height: 50)
        rightObstructionSize = CGSize(width: 50, height: 50)

        adPartnerName = .kIASPartner;
        customPartnerName = "IAS";
        
        adUserAgent = .kDefaultUserAgent
        customUserAgent = ""
        
        adPartnerVersion = "1.0"
        includeContentURL = false
        isMuted = false
        contentUrl.setIsIncluded(isIncluded: false, contentUrl: nil)
    }
    
    init() {
        sdkProvider.initialize()
        sdkProvider.setConfig(self)
        self.reset()
    }
    
    
    public var adDimension : AdDimension = .kDim320_50 {
        didSet {
            switch adDimension {
            case .kDim320_50:
                customAdSize = CGSize(width: 320, height: 50)
                break
            case .kDim300_50:
                customAdSize = CGSize(width: 300, height: 50)
                break
            case .kDim300_250:
                customAdSize = CGSize(width: 300, height: 250)
                break
            case .kDim1500_50:
                customAdSize = CGSize(width: 1500, height: 50)
                break
            case .kDim50_1500:
                customAdSize = CGSize(width: 50, height: 1500)
                break
            case .kDim1500_1500:
                customAdSize = CGSize(width: 1500, height: 1500)
                break
            case .kDim1_1:
                customAdSize = CGSize(width: 1, height: 1)
                break
            case .kDim300_1:
                customAdSize = CGSize(width: 300, height: 1)
                break
            case .kDim1_50:
                customAdSize = CGSize(width: 1, height: 50)
                break
            case .kDim2000_2000:
                customAdSize = CGSize(width: 2000, height: 2000)
                break
            case .kDimAuto:
                customAdSize = CGSize(width: 0, height: 0)
                break
            default:
                break
            }
        }
    }
   
    func setAdDimension(adDimension: AdDimension) {
        self.adDimension = adDimension
        self.updateAdSize()
    }
    
    func setAdPosition(adPosition: AdPosition)  {
        return self.adPosition = .kTop
    }

    /**
     - This funtion is used to return array of available options as per scenario criteria
     - Returns: - Array of Enum value
     */
    func availableOptions() -> [Int] {
        var array : [Int] = [Config.AD_SDK, Config.AD_SCENARIO]
        var sizeIsAvailable = true;
        var positionIsAvailable = false;
        var countIsAvailable = false;
        var isMuteAvaiable = false;
        var isAutoPlayAvaialble = false;
        
        switch adScenario {
            
        case .kObstructionScenario:
            positionIsAvailable = true;
            array.append(Config.AD_OBSTRUCTION_TYPE)
            array.append(Config.AD_INCLUDE_TOP_OBSTRUCTION)
            array.append(Config.AD_INCLUDE_BOTTOM_OBSTRUCTION)
            array.append(Config.AD_INCLUDE_LEFT_OBSTRUCTION)
            array.append(Config.AD_INCLUDE_RIGHT_OBSTRUCTION)
            
            if includeTopObstruction {
                array.append(Config.AD_TOP_OBSCTRUCTION_SIZE)
            }
            
            if includeBottomObstruction {
                array.append(Config.AD_BOTTOM_OBSCTRUCTION_SIZE)
            }
            if includeLeftObstruction {
                array.append(Config.AD_LEFT_OBSCTRUCTION_SIZE)
            }
            if includeRightObstruction {
                array.append(Config.AD_RIGHT_OBSCTRUCTION_SIZE)
            }
            break
            
       
        default:
            positionIsAvailable = true
            if adBannerType == IASAdType.kIASNativeAudio.rawValue {
                positionIsAvailable = false
                sizeIsAvailable = false
                isMuteAvaiable = true
                isAutoPlayAvaialble = true
            }
         
            break
        }
//        if (sdkProvider.supportBannerType()) {
//            array.append(Config.AD_BANNER_TYPE)
//        }
//
//        if (sdkProvider.supportBannerUrl()) {
//            array.append(Config.AD_BANNER_URL)
//        }
//
//        if sdkProvider.supportContentUrl() {
//            array.append(Config.AD_INCLUDE_CONTENT_URL)
//        }
        
        if (positionIsAvailable) {
            array.append(Config.AD_POSITION)
        }
        
//        if (sizeIsAvailable && sdkProvider.supportArbitrarySize() {
//            array.append(Config.AD_DIMENSIONS)
//        }
//
        
//        if sdkProvider.supportDifferentVASTVersion() {
//            array.append(Config.AD_VAST_VERSION)
//        }
                
        if self.includeContentURL {
            array.append(Config.AD_CONTENT_URL)
        }
        
//        if sdkProvider.supportPartnerName() {
//            array.append(Config.AD_PARTNER_NAME)
//            if adPartnerName == .kCustomPartner {
//                array.append(Config.AD_CUSTOM_PARTNER_NAME)
//            }
//            array.append(Config.AD_PARTNER_VERSION)
//        }
        
        if isMuteAvaiable {
            array.append(Config.AD_AUDIO_MUTE)
        }

        
//        if sdkProvider.supportUserAgent()
//        {
//            array.append(Config.AD_USER_AGENT)
//            if adUserAgent == .kCustomUserAgent {
//                array.append(Config.AD_CUSTOM_USER_AGENT)
//            }
//        }
        return array
    }
    
    func updateAdSize() {
        switch adDimension {
        case .kDim320_50:
            self.customAdSize = CGSize(width: 320, height: 50);
            break;
            
        case .kDim300_50:
            self.customAdSize = CGSize(width: 300, height: 50);
            break;
            
        case .kDim300_250:
            self.customAdSize = CGSize(width: 300, height: 250);
            break;
            
        case .kDim1500_50:
            self.customAdSize = CGSize(width: 1500, height: 50);
            break;
            
        case .kDim50_1500:
            self.customAdSize = CGSize(width: 50, height: 1500);
            break;
            
        case .kDim1500_1500:
            self.customAdSize = CGSize(width: 1500, height: 1500);
            break;
            
        case .kDim1_1:
            self.customAdSize = CGSize(width: 1, height: 1);
            break;
            
        case .kDim300_1:
            self.customAdSize = CGSize(width: 300, height: 1);
            break;
            
        case .kDim1_50:
            self.customAdSize = CGSize(width: 1, height: 50);
            break;
            
        case .kDim2000_2000:
            self.customAdSize = CGSize(width: 2000, height: 2000);
            break;
            
        case .kDimAuto:
            self.customAdSize = CGSize(width: 0, height: 0);
            break;
            
        default:
            break;
            
        }
    }
    
    private func adjustScenario() {
//        if !sdkProvider.supportScenario(adScenario.rawValue) {
//            adScenario = .kSimpleScenario
//        }
    }
    
    private func adjustDimension() {
//        if !sdkProvider.supportDimension(adDimension.rawValue) {
//            adDimension = Config.AdDimension(rawValue: sdkProvider.defaultDimension())!
//        }
//        if !sdkProvider.supportDimension(hiddenAdDimension.rawValue) {
//            hiddenAdDimension = Config.AdDimension(rawValue: sdkProvider.defaultDimension())!
//        }
    }
    
    
    func partnerName() -> String? {
        if adPartnerName == AdPartnerName.kIASPartner {
            return "IAS"
        } else {
            return customPartnerName
        }
    }
    
    func setCustomPartnerName(_ customPartnerName: String?) {
        self.customPartnerName = customPartnerName
    }
    
    func userAgent() -> String? {
        if adUserAgent == AdUserAgent.kDefaultUserAgent {
            return ""
        } else {
            return customUserAgent
        }
    }
    
    func setCustomUserAgent(_ customUserAgent: String?) {
        self.customUserAgent = customUserAgent
    }
    
    func setPartnerVersion(_ partnerVersion: String?) {
        self.adPartnerVersion = partnerVersion
    }
}

extension Config: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let config = Config()
        config.adBannerType = adBannerType
        config.adBannerURL = adBannerURL
        config.adDimension = adDimension
        config.adPosition = adPosition
        config.adScenario = adScenario
        
        return config
    }
}
class ContentUrl {
    private var mContentUrl : String? = nil
    private var mIsIncluded : Bool = false
    
    /**
     - This method id used to set a value of isIncluded and contentUrl variables
     - Parameter  isIncluded : Return a contentUrl switch value
     - Parameter  contentUrl : Return a contentUrl textfield value
     */
    func setIsIncluded(isIncluded : Bool, contentUrl : String?) {
        mIsIncluded = isIncluded
        if isIncluded {
            mContentUrl = contentUrl
        }
        else{
            mContentUrl = nil
        }
    }
    
    /**
     - Method is used for setting content url
     - Parameter contentUrl: Used for return a contentUrl textfield value
     */
    func setContentUrl(contentUrl : String?) {
        mContentUrl = contentUrl
    }
    /**
     - This method return a contentUrl value
     - Returns: Content Url having a datatype is String
     */
    func getContentUrl() -> String? {
        return mContentUrl
    }
    
    /**
     - This method will return a isINclude flag value
     - Returns: It will return a mIsInclude variable's value
     */
    func isIncluded() -> Bool {
        return mIsIncluded
    }
}

