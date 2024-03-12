//
//  ViewController.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 04/05/21.
//

import UIKit
import AVKit
import TVUIKit

class ViewController: UIViewController {
    
    private static let SINGLE_PAGE_SEGUE = "singlePageSegue"
    private static let OBSTRUCTION_VIEW_SEGUE = "obstructionViewSegue"
    
    var info: IASNativeVideoAdInfo?
    
    @IBOutlet weak var applyButton: TVCaptionButtonView!
//    @IBOutlet weak var adURLTextField: UITextField!
    @IBOutlet weak var resetButton: TVCaptionButtonView!
    @IBOutlet weak var logButton: TVCaptionButtonView!
    
    
    //Ad Type
    @IBOutlet weak var selectAdsSection: UIView!
    @IBOutlet weak var videoAdsButton: UIButton!
    @IBOutlet weak var audioAdsButton: UIButton!
    @IBOutlet weak var adTypeSelectButton: UIButton!
    
    // Ad scenario
    @IBOutlet weak var selectAdsScenarioSection: UIView!
    @IBOutlet weak var SimpleScenarioButton: UIButton!
    @IBOutlet weak var ObstructionScenarioButton: UIButton!
    @IBOutlet weak var adTypeScenarioButton: UIButton!
    
    // Partner
    @IBOutlet weak var selectPartnerSection: UIView!
    @IBOutlet weak var partnerSelectButton: UIButton!
    @IBOutlet weak var IASButton: UIButton!
    @IBOutlet weak var CustomPartnerButton: UIButton!
    @IBOutlet weak var AddCustomPartnerButton: UIButton!
    @IBOutlet weak var CustomPartnerStackView:UIStackView!
    @IBOutlet weak var PartnerStackView:UIStackView!
    @IBOutlet weak var customPartnerTextField: UITextField!
  
    //User Agent
    @IBOutlet weak var selectUserAgentSection: UIView!
    @IBOutlet weak var userAgentSelectButton: UIButton!
    @IBOutlet weak var DefaultButton: UIButton!
    @IBOutlet weak var CustomUserAgentButton: UIButton!
    @IBOutlet weak var AddCustomUserAgentButton: UIButton!
    @IBOutlet weak var CustomUserAgentStackView:UIStackView!
    @IBOutlet weak var UserAgentStackView:UIStackView!
    @IBOutlet weak var cutomUserAgentTextField: UITextField!
    
    //Content url
    @IBOutlet weak var contentURLSelectButton: UIButton!
    //Ad Url
    @IBOutlet weak var adURLTextField: UITextField!
    
    //VAST version
    @IBOutlet weak var selectVASTVersionSection: UIView!
    @IBOutlet weak var VAST_42_Button: UIButton!
    @IBOutlet weak var VAST_41_Button: UIButton!
    @IBOutlet weak var VAST_40_Button: UIButton!
    @IBOutlet weak var VAST_30_Button: UIButton!
    @IBOutlet weak var VAST_20_Button: UIButton!
   
    // Obstruction Button
    
    @IBOutlet weak var topObstructionButton: UIButton!
    @IBOutlet weak var bottomObstructionButton: UIButton!
    @IBOutlet weak var leftObstructionButton: UIButton!
    @IBOutlet weak var rightObstructionButton: UIButton!

    @IBOutlet weak var topObsHeight: UITextField!
    @IBOutlet weak var topObsWidth: UITextField!
    @IBOutlet weak var bottomObsHeight: UITextField!
    @IBOutlet weak var bottomObsWidth: UITextField!
    @IBOutlet weak var leftObsHeight: UITextField!
    @IBOutlet weak var leftObsWidth: UITextField!
    @IBOutlet weak var rightObsHeight: UITextField!
    @IBOutlet weak var rightObsWidth: UITextField!
    @IBOutlet weak var rightbtnview: UIStackView!
    @IBOutlet weak var righttxtview: UIStackView!
    @IBOutlet weak var leftbtnview: UIStackView!
    @IBOutlet weak var lefttxtview: UIStackView!
    @IBOutlet weak var topbtnview: UIStackView!
    @IBOutlet weak var toptxtview: UIStackView!
    @IBOutlet weak var bottombtnview: UIStackView!
    @IBOutlet weak var bottomtxtview: UIStackView!
    
    var adTypeDelegate = AdTypeDelegates()
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        logsTextView.isUserInteractionEnabled = true
//        logsTextView.isSelectable = true
//        logsTextView.isScrollEnabled = true
//
//        logsTextView.panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouch.TouchType.indirect.rawValue)]
//        logsTextView.text = AppLog.sharedAppLog.logs.joined(separator: "\n")
    }
    
    
    @IBAction func VideoAdsClicked(_ sender: Any) {
        adTypeSelectButton.setTitle("Video Ads", for: .normal)
        Config.sharedConfig.adBannerType = IASAdType.kIASNativeVideo.rawValue
        ObstructionScenarioButton.isHidden = false
        selectAdsSection.isHidden = true
    }
    @IBAction func audioAdsClicked(_ sender: Any) {
        adTypeSelectButton.setTitle("Audio Ads", for: .normal)
        Config.sharedConfig.adBannerType = IASAdType.kIASNativeAudio.rawValue
        ObstructionScenarioButton.isHidden = true
        selectAdsSection.isHidden = true
    }
    
    @IBAction func adTypeClick(_ sender: Any) {
        print("inside adType")
        selectAdsSection.isHidden = false
    }
 
    @IBAction func adScenarioClick(_ sender: UIButton) {
        adTypeDelegate.ScenarioClick(view: view)
    }
    
    @IBAction func simpleScenarioClick(_ sender: UIButton) {
        Config.sharedConfig.adScenario = Config.AdScenario.kSimpleScenario
        adTypeDelegate.SimpleScenarioClicked(view: view)
    }
    
    @IBAction func obstructionScenarioClick(_ sender: UIButton) {
        
//        Config.sharedConfig.adScenario = Config.AdScenario.kObstructionScenario
//        adTypeDelegate.ObstructionScenarioClicked(view: view)
    }
    
    
    // Functions for Partner selection
    @IBAction func IASPartnerClicked(_ sender: Any) {
        Config.sharedConfig.adPartnerName = Config.AdPartnerName.kIASPartner
        adTypeDelegate.IASPartnerClicked(view: view)
    }
    @IBAction func CustomPartnerClicked(_ sender: Any) {
        Config.sharedConfig.adPartnerName = Config.AdPartnerName.kCustomPartner
        adTypeDelegate.CustomPartnerClicked(view: view)
    }
    @IBAction func adPartnerClick(_ sender: Any) {
        adTypeDelegate.adPartnerClick(view: view)
    }
    @IBAction func addCustomPartnerClicked(_ sender: Any) {
        adTypeDelegate.addCustomPartnerClicked(view: view)
    }
    
    //Functions for User Agent button events
    @IBAction func userAgentClick(_ sender: Any) {
        adTypeDelegate.adCustomAgentClick(view: view)
    }
    
    @IBAction func defaultUserAgentClick(_ sender: UIButton) {
        adTypeDelegate.DefaultUserAgentClicked(view: view)
    }
    
    @IBAction func customUserAgentClick(_ sender: UIButton) {
        adTypeDelegate.CustomUserAgentClicked(view: view)
    }
    
    @IBAction func addCustomUserAgentClick(_ sender: UIButton) {
        adTypeDelegate.addCustomUserAgentClicked(view: view)
    }
    
    
    //Functions of Content Url
    @IBAction func contentUrlClick(_ sender: UIButton) {
        adTypeDelegate.contentURLClicked(view: view)
    }
    
    // Functions of VAST Version
    @IBAction func selectVastVersion(_ sender: UIButton) {
        adTypeDelegate.selectVASTVersionClick(view: view)
    }
    @IBAction func selectVast42(_ sender: UIButton) {
        adTypeDelegate.selectVAST(view: view, VASTVersion:AppConstants.Labels.VAST42)
    }
    @IBAction func selectVast41(_ sender: UIButton) {
        adTypeDelegate.selectVAST(view: view, VASTVersion:AppConstants.Labels.VAST41)
    }
    @IBAction func selectVast40(_ sender: UIButton) {
        adTypeDelegate.selectVAST(view: view, VASTVersion:AppConstants.Labels.VAST40)
    }
    @IBAction func selectVast30(_ sender: UIButton) {
        adTypeDelegate.selectVAST(view: view, VASTVersion:AppConstants.Labels.VAST30)
    }
    
    @IBAction func selectVast20(_ sender: UIButton) {
        adTypeDelegate.selectVAST(view: view, VASTVersion:AppConstants.Labels.VAST20)
    }
    
    //Obstruction Click
    
    @IBAction func topObstructionClick(_ sender: UIButton) {
        adTypeDelegate.topObstructionClicked(view: view)
    }
    @IBAction func bottomObstructionClick(_ sender: UIButton) {
        adTypeDelegate.bottomObstructionClicked(view: view)
    }
    @IBAction func leftObstructionClick(_ sender: UIButton) {
        adTypeDelegate.leftObstructionClicked(view: view)
    }
    
    @IBAction func rightObstructionClick(_ sender: UIButton) {
        adTypeDelegate.rightObstructionClicked(view: view)
    }
    
    @IBAction func applyButtonClick(_ sender: TVCaptionButtonView) {
        print("+++++++++++++++++++")
        print(Config.sharedConfig.vastVersion)
        
        print(adURLTextField.text!)
        Config.sharedConfig.adBannerURL = adURLTextField.text
        
        var segueIdentifier: String? = nil
        switch Config.sharedConfig.adScenario {
        case .kSimpleScenario:
            segueIdentifier = ViewController.SINGLE_PAGE_SEGUE
            break
        
        case .kObstructionScenario:
            segueIdentifier = ViewController.OBSTRUCTION_VIEW_SEGUE;
            break;
            
        default:
            segueIdentifier = ViewController.SINGLE_PAGE_SEGUE;
            break;
        }
        
//        AppLog.sharedLog.clear()
//        AppLog.sharedLog.applyConfig()
        performSegue(withIdentifier: segueIdentifier!, sender: nil)
        
//        let adsType : String = adTypeSelectButton.currentTitle ?? AppConstants.Labels.nativeVideoAds
//        var adTypeEnum: adType
//
//
//        // Input fields validation
//        if (InputFieldValidation.partnerVersionValidation(view: view) == true &&
//                InputFieldValidation.VASTVersionValidation(view: view) == true &&
//                InputFieldValidation.userAgenValidation(view: view) == true){
//
//            //Set obstruction value if ad scenario is obstruction
//            ObstructionScenario.setobstruction(view: view)
//
//            // Check the ad Type and set ENUM Case for further execution
//            if adsType == AppConstants.Labels.nativeVideoAds {
//                 adTypeEnum = adType.nativeVideoAd
//            }
//            else  if adsType == AppConstants.Labels.nativeAudioAds{
//                 adTypeEnum = adType.nativeAudioAd
//            }
//            else{
//                adTypeEnum = adType.nativeDisplayAd
//            }
//
//            //According to the ad Type particular case Executed
//            switch adTypeEnum {
//            case .nativeVideoAd:
//                let viewController = IASVideoView(nibName: "IASVideoViewController", bundle: Bundle.main)
//                 self.navigationController!.pushViewController(viewController, animated: true)
//
//            case .nativeAudioAd:
//                let viewController = IASAudioPlayerController(nibName: "IASAudioViewController", bundle: Bundle.main)
//                 self.navigationController!.pushViewController(viewController, animated: true)
//
//            case .nativeDisplayAd:
//                let viewController = IASDisplayAdViewController(nibName: "IASDisplayAdViewController", bundle: Bundle.main)
//                 self.navigationController!.pushViewController(viewController, animated: true)
//            }
//        }
        
    }
    
    @IBAction func resetButtonClick(_ sender: TVCaptionButtonView) {
    }
    
    @IBAction func logsButtonClick(_ sender: TVCaptionButtonView) {
    }
    
   
    
    @IBAction func resetTapped(_ sender: Any) {
        adURLTextField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Ad Type Button title" + adTypeSelectButton.currentTitle! ?? "No value")
        if adTypeSelectButton.currentTitle == "Video Ads"{
            if segue.identifier == "videoPlayerSegue" {
                let destVC : IASVideoPlayerController = segue.destination as! IASVideoPlayerController
                   destVC.info = info!
            } else if segue.identifier == "AVVideoPlayerSegue" {
                if segue.identifier == "AVVideoPlayerSegue" {
                    let destVC : IASAVVideoPlayerViewController = segue.destination as! IASAVVideoPlayerViewController
                       destVC.info = info!
                }
            }
        }
        else{
            if segue.identifier == "audioPlayerSegue" {
                let destVC : IASAudioPlayerController = segue.destination as! IASAudioPlayerController
                   destVC.info = info!
            } else if segue.identifier == "AVAudioPlayerSegue" {
                if segue.identifier == "AVAudioPlayerSegue" {
                    let destVC : IASAVAudioPlayerViewController = segue.destination as! IASAVAudioPlayerViewController
                       destVC.info = info!
                }
            }
        }
        
    }

}

