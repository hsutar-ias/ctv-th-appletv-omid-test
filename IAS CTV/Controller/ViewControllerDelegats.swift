//
//  viewControllerDelegats.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 10/07/23.
//

import Foundation
import UIKit

//prootocol for controlles and clicked event of adconfig screen
protocol ViewControllerDelegats {
   
    func videoadsClicked(view: UIView)
    func audioadsClicked(view: UIView)
    func displayadsClicked(view: UIView)
    func adTypeClick(view : UIView)
    func IASPartnerClicked(view: UIView)
    func CustomPartnerClicked(view: UIView)
    func adPartnerClick(view: UIView)
    func addCustomPartnerClicked(view: UIView)
    func SimpleScenarioClicked(view: UIView)
    func ObstructionScenarioClicked(view: UIView)
    func ScenarioClick(view: UIView)
    func DefaultUserAgentClicked(view: UIView)
    func CustomUserAgentClicked(view: UIView)
    func adCustomAgentClick(view: UIView)
    func addCustomUserAgentClicked(view: UIView)
    func contentURLClicked(view: UIView)
    func rightObstructionClicked(view: UIView)
    func leftObstructionClicked(view: UIView)
    func topObstructionClicked(view: UIView)
    func bottomObstructionClicked(view: UIView)
    func errorOkayClicked(view: UIView)
    
}
