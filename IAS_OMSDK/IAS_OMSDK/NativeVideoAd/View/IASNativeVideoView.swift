//
//  IASNativeVideoView.swift
//  IAS_OMSDK
//
//  Created by Archana Deshmukh on 02/08/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation
import UIKit
import TVUIKit
import AVKit
/**
- IASNativeVideoView class extends IASVideoViewInterface and implements it's functions
- This class is used for handling a banner video ad scenario
*/
class IASNativeVideoView: UIView, IASVideoViewInterface {
    var videoView: IASVideoView?
    
    var mainView: UIView? {
        return self
    }
    
    weak var delegate: IASVideoDelegate?
    
    @IBOutlet public weak var muteSkipStackView: UIStackView!
    @IBOutlet public weak var muteButton: TVCaptionButtonView!
    @IBOutlet public weak var skipButton: TVCaptionButtonView!
  
    @IBAction func skipButtonClicked(_ sender: TVCaptionButtonView) {
//        delegate?.skipButtonTapped()
        print("Skip clicked............")

    }
    @IBAction func muteButtonClicked(_ sender: TVCaptionButtonView) {
        print("mute clicked............")
    }

    func setControlsVisibility(_ visibility: Bool) {
        skipButton.isHidden = !visibility
    }

    class func loadFromNib() -> IASNativeVideoView? {
        return Bundle.main.loadNibNamed("IASNativeVideoView", owner: nil, options: nil)?.first as? IASNativeVideoView
    }

}

