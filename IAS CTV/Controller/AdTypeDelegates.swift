//
//  AdTypeDelegates.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 10/07/23.
//

import Foundation
import UIKit

class AdTypeDelegates: NSObject, ViewControllerDelegats{
    
    
    // when ad scenario button clicked.
    func ScenarioClick(view: UIView) {
        visibilityStateChange(view: [view.viewWithTag(config.SelectAdScenarioView)! as UIView],state: [false])

    }
    
    // Functions for Partner selection
    func adPartnerClick(view: UIView) {
        visibilityStateChange(view: [view.viewWithTag(config.SelectPartnerView)! as UIView],state: [false])
    }
    
    // When custom partner button clicked
    func addCustomPartnerClicked(view: UIView) {
        let partnerSelectButton = view.viewWithTag(config.SelectPartnerBtn) as! UIButton
        let cutomPartnerTextField = view.viewWithTag(config.CustomPartnerTxtField) as! UITextField
        
        Config.sharedConfig.setCustomPartnerName(cutomPartnerTextField.text)
        
        partnerSelectButton.setTitle(cutomPartnerTextField.text, for: .normal)
        visibilityStateChange(view: [view.viewWithTag(config.SelectPartnerView)! as UIView, view.viewWithTag(config.PartnerStackView)! as UIView, view.viewWithTag(config.CustomPartnerStackView)! as UIView],state: [true,false,true])
    }
    
    // Functions for Scenario selection
    func SimpleScenarioClicked(view: UIView) {
        visibilityStateChange(view: [view.viewWithTag(config.RightObsBtnSection)! as UIView,view.viewWithTag(config.RightObsTxtSection)! as UIView,view.viewWithTag(config.LeftObsBtnSection)! as UIView,view.viewWithTag(config.LeftObsTxtSection)! as UIView,        view.viewWithTag(config.TopObsBtnSection)! as UIView,view.viewWithTag(config.TopObsTxtSection)! as UIView,view.viewWithTag(config.BottomObsBtnSection)! as UIView,view.viewWithTag(config.BottomObsTxtSection)! as UIView,view.viewWithTag(config.SelectAdScenarioView)! as UIView ], state: [true,true,true,true,true,true,true,true,true])
        
        let adTypeScenarioButton = view.viewWithTag(config.AdScenarioBtn) as! UIButton
        adTypeScenarioButton.setTitle(AppConstants.Labels.simpleScenario, for: .normal)
    }
    
    // When the user selects obstruction as an ad scenario.
    func ObstructionScenarioClicked(view: UIView) {
        visibilityStateChange(view: [view.viewWithTag(config.RightObsBtnSection)! as UIView, view.viewWithTag(config.LeftObsBtnSection)! as UIView, view.viewWithTag(config.TopObsBtnSection)! as UIView, view.viewWithTag(config.BottomObsBtnSection)! as UIView, view.viewWithTag(config.SelectAdScenarioView)! as UIView],state: [false,false,false,false,true])
        
        let adTypeScenarioButton = view.viewWithTag(config.AdScenarioBtn) as! UIButton
        adTypeScenarioButton.setTitle(AppConstants.Labels.obstructionScenario, for: .normal)
    }
  
    
    // Functions for User Agent selection
    func DefaultUserAgentClicked(view: UIView) {
        let userAgentSelectButton = view.viewWithTag(config.UserAgentBtn) as! UIButton
        userAgentSelectButton.setTitle(AppConstants.Labels.defaultUserAgent, for: .normal)
        Config.sharedConfig.adUserAgent = Config.AdUserAgent.kDefaultUserAgent
        visibilityStateChange(view: [view.viewWithTag(config.SelectUserAgentView)! as UIView],state: [true])
    }
    
    // When Custom User agent clicked
    func CustomUserAgentClicked(view: UIView) {
        Config.sharedConfig.adUserAgent = Config.AdUserAgent.kCustomUserAgent
        visibilityStateChange(view: [view.viewWithTag(config.UserAgentStackView)! as UIView,view.viewWithTag(config.CustomUserAgentStackView)!],state: [true,false])
    }
    
    func adCustomAgentClick(view: UIView) {
        visibilityStateChange(view: [view.viewWithTag(config.SelectUserAgentView)! as UIView],state: [false])

    }
    
    // When the user adds a custom user agent and presses OK to add it as a custom user agent, this function is executed.
    func addCustomUserAgentClicked(view: UIView) {
        let userAgentSelectButton = view.viewWithTag(config.UserAgentBtn) as! UIButton
        let cutomUserAgentTextField = view.viewWithTag(config.CustomUserAgentTxtField) as! UITextField
        
        userAgentSelectButton.setTitle(cutomUserAgentTextField.text, for: .normal)
        Config.sharedConfig.setCustomUserAgent(cutomUserAgentTextField.text)
        
        visibilityStateChange(view: [view.viewWithTag(config.SelectUserAgentView)! as UIView,
                                     view.viewWithTag(config.UserAgentStackView)!as UIView,
                                     view.viewWithTag(config.CustomUserAgentStackView)!as UIView],state: [true,false,true])
   
    }
    
    // For Toggle experience on clicking of button like True and False
    func contentURLClicked(view: UIView) {
        let contentURLSelectButton = view.viewWithTag(config.ContentURLBtn) as! UIButton
        let contentURLtxtStack = view.viewWithTag(config.ContentURLTxtFieldStack) as! UIStackView
        let contentURLtxt = view.viewWithTag(config.ContentURLTxtField) as! UITextField
        Config.sharedConfig.contentUrl.setContentUrl(contentUrl: contentURLtxt.text)
        
        if (contentURLSelectButton.title(for: .normal) == AppConstants.Boolean.falseString) {
            contentURLSelectButton.setTitle(AppConstants.Boolean.trueString, for: .normal)
            
            contentURLtxtStack.isHidden = false
            print("contentURLtxt.text=--------"+(contentURLtxt.text ?? ""))
        }
        else{
            
            contentURLSelectButton.setTitle(AppConstants.Boolean.falseString, for: .normal)
            contentURLtxtStack.isHidden = true
        }
    }
    
    // To create Right obstruction
    func rightObstructionClicked(view: UIView) {
        let rightObstructionButton = view.viewWithTag(config.RightBtn) as! UIButton
        if (rightObstructionButton.title(for: .normal) == AppConstants.Boolean.falseString) {
            rightObstructionButton.setTitle(AppConstants.Boolean.trueString, for: .normal)
            visibilityStateChange(view: [view.viewWithTag(config.RightObsTxtSection)! as UIView],state: [false])
        }
        else{
            visibilityStateChange(view: [view.viewWithTag(config.RightObsTxtSection)! as UIView],state: [true])
            rightObstructionButton.setTitle(AppConstants.Boolean.falseString, for: .normal)
        }
    }
    
    // To create Left obstruction
    func leftObstructionClicked(view: UIView) {
        let leftObstructionButton = view.viewWithTag(config.LeftBtn) as! UIButton

        if (leftObstructionButton.title(for: .normal) == AppConstants.Boolean.falseString) {
            leftObstructionButton.setTitle(AppConstants.Boolean.trueString, for: .normal)
            visibilityStateChange(view: [view.viewWithTag(config.LeftObsTxtSection)! as UIView],state: [false])
        }
        else{
            visibilityStateChange(view: [view.viewWithTag(config.LeftObsTxtSection)! as UIView],state: [true])
            leftObstructionButton.setTitle(AppConstants.Boolean.falseString, for: .normal)
        }
    }
    
    // To create Top obstruction
    func topObstructionClicked(view: UIView) {
        let topObstructionButton = view.viewWithTag(config.TopBtn) as! UIButton

        if (topObstructionButton.title(for: .normal) == AppConstants.Boolean.falseString) {
            topObstructionButton.setTitle(AppConstants.Boolean.trueString, for: .normal)
            visibilityStateChange(view: [view.viewWithTag(config.TopObsTxtSection)! as UIView],state: [false])
        }
        else{
            visibilityStateChange(view: [view.viewWithTag(config.TopObsTxtSection)! as UIView],state: [true])
            topObstructionButton.setTitle(AppConstants.Boolean.falseString, for: .normal)
        }
    }
    
    // To create Bottom obstruction
    func bottomObstructionClicked(view: UIView) {
        let bottomObstructionButton = view.viewWithTag(config.BottomBtn) as! UIButton

        if (bottomObstructionButton.title(for: .normal) == AppConstants.Boolean.falseString) {
            bottomObstructionButton.setTitle(AppConstants.Boolean.trueString, for: .normal)
            visibilityStateChange(view: [view.viewWithTag(config.BottomObsTxtSection)! as UIView],state: [false])
        }
        else{
            visibilityStateChange(view: [view.viewWithTag(config.BottomObsTxtSection)! as UIView],state: [true])
            bottomObstructionButton.setTitle(AppConstants.Boolean.falseString, for: .normal)
        }
    }
    
    // When the OK button of the error prompt is pressed.
    func errorOkayClicked(view: UIView) {
        visibilityStateChange(view: [view.viewWithTag(config.DisplayErrorView)! as UIView],state: [true])
        let errorSectionTextField = view.viewWithTag(config.ErrorText) as! UILabel
        errorSectionTextField.clearsContextBeforeDrawing = true
    }
    
    // When select ad type button clicked
    func adTypeClick(view: UIView) {
        visibilityStateChange(view: [view.viewWithTag(config.SelectAdTypeView)! as UIView],state: [false])

    }
    
    // When User select IAS as a partner
    func IASPartnerClicked(view: UIView) {
        let partnerSelectButton = view.viewWithTag(config.SelectPartnerBtn) as! UIButton
        partnerSelectButton.setTitle(AppConstants.Labels.iasPartner, for: .normal)
        Config.sharedConfig.adPartnerName = Config.AdPartnerName.kIASPartner
        visibilityStateChange(view: [view.viewWithTag(config.SelectPartnerView)! as UIView],state: [true])
    }
    
    // When User select Custom as a partner
    func CustomPartnerClicked(view: UIView) {
        Config.sharedConfig.adPartnerName = Config.AdPartnerName.kCustomPartner
        visibilityStateChange(view: [view.viewWithTag(config.PartnerStackView)! as UIView,view.viewWithTag(config.CustomPartnerStackView)! as UIView],state: [true, false])
    }
    
    // To change the visibility of a particular view.
    open func visibilityStateChange(view: Array<UIView>, state: Array<Bool>){
        let numberOfView = view.count
        for i in 0...numberOfView - 1{
            view[i].isHidden = state[i]
        }
    }
    
    //When the ad type has been changed, this function is called to hide all obstruction scenario fields.
    func clearAdScenario(view: UIView){
        let adTypeScenarioButton = view.viewWithTag(config.AdScenarioBtn) as! UIButton
        adTypeScenarioButton.setTitle(AppConstants.Labels.simpleScenario, for: .normal)
        visibilityStateChange(view: [view.viewWithTag(config.RightObsBtnSection)! as UIView,
                                     view.viewWithTag(config.RightObsTxtSection)! as UIView,
                                     view.viewWithTag(config.LeftObsBtnSection)! as UIView,
                                     view.viewWithTag(config.LeftObsTxtSection)! as UIView,
                                     view.viewWithTag(config.TopObsBtnSection)! as UIView,
                                     view.viewWithTag(config.TopObsTxtSection)! as UIView,
                                     view.viewWithTag(config.BottomObsBtnSection)! as UIView,
                                     view.viewWithTag(config.BottomObsTxtSection)! as UIView], state: [true,true,true,true,true,true,true,true])
    }
    
    // Functions for Ad Type selection
    func setAdText(title: String, view: UIView) {
        clearAdScenario(view: view)
        let adTypeSelectButton =  view.viewWithTag(config.AdTypeBtn) as! UIButton
        adTypeSelectButton.setTitle(title, for: .normal)
        visibilityStateChange(view: [view.viewWithTag(config.SelectAdTypeView)! as UIView],state: [true])
    }
    
    func videoadsClicked(view: UIView) {
        setAdText(title: AppConstants.Labels.nativeVideoAds, view: view)
        visibilityStateChange(view: [view.viewWithTag(config.ObstructionScenario) as! UIButton], state: [false])
    }
    
    func audioadsClicked(view: UIView) {
        setAdText(title: AppConstants.Labels.nativeAudioAds, view: view)
        visibilityStateChange(view: [view.viewWithTag(config.ObstructionScenario) as! UIButton], state: [true])
    }
    
    func displayadsClicked(view: UIView) {
        setAdText(title: AppConstants.Labels.nativeDisplayAds, view: view)
        visibilityStateChange(view: [view.viewWithTag(config.ObstructionScenario) as! UIButton], state: [false])
    }
    

    //VAST version
    func selectVASTVersionClick(view: UIView) {
        visibilityStateChange(view: [view.viewWithTag(config.selectVASTClick)! as UIView],state: [false])
    }
    
    // Functions for Ad Type selection
    func setVASTVersionText(title: String, view: UIView) {
        clearAdScenario(view: view)
        let vastVersionSelectButtom =  view.viewWithTag(config.VASTBtn) as! UIButton
        vastVersionSelectButtom.setTitle(title, for: .normal)
        visibilityStateChange(view: [view.viewWithTag(config.selectVASTClick)! as UIView],state: [true])
    }
    
    func selectVAST(view: UIView, VASTVersion: String) {
        switch VASTVersion{
        case AppConstants.Labels.VAST42:
            Config.sharedConfig.vastVersion = Config.VASTVersion.kVastVersion42
            setVASTVersionText(title: AppConstants.Labels.VAST42, view: view)
            break;
        case AppConstants.Labels.VAST41:
            Config.sharedConfig.vastVersion = Config.VASTVersion.kVastVersion41
            setVASTVersionText(title: AppConstants.Labels.VAST41, view: view)
            break;
        case AppConstants.Labels.VAST40:
            Config.sharedConfig.vastVersion = Config.VASTVersion.kVastVersion40
            setVASTVersionText(title: AppConstants.Labels.VAST40, view: view)
            break;
        case AppConstants.Labels.VAST30:
            Config.sharedConfig.vastVersion = Config.VASTVersion.kVastVersion30
            setVASTVersionText(title: AppConstants.Labels.VAST30, view: view)
            break;
        case AppConstants.Labels.VAST20:
            Config.sharedConfig.vastVersion = Config.VASTVersion.kVastVersion20
            setVASTVersionText(title: AppConstants.Labels.VAST20, view: view)
            break;
        default:
            Config.sharedConfig.vastVersion = Config.VASTVersion.kVastVersion42
            setVASTVersionText(title: AppConstants.Labels.VAST42, view: view)
            break;
        }
        visibilityStateChange(view: [view.viewWithTag(config.selectVASTClick) as! UIView], state: [true])
    }
    
}
