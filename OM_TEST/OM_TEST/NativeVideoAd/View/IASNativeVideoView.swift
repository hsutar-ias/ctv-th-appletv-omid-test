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
    
    var view: UIView!
    
    weak var delegate: IASVideoDelegate?
    
    @IBOutlet public weak var muteSkipStackView: UIStackView!
    
    @IBOutlet public weak var skipButton: TVCaptionButtonView!
    
    @IBOutlet public weak var muteButton: TVCaptionButtonView!
  
    @IBAction func skipButtonClicked(_ sender: TVCaptionButtonView) {
//        delegate?.skipButtonTapped()
        print("Skip clicked............")

    }
    @IBAction func muteButtonClicked(_ sender: TVCaptionButtonView) {
        print("mute clicked............")
    }

    
//    required init?(coder aDecoder: NSCoder) {
//            super.init(coder: aDecoder)
//            setup()
//        }
//
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//           setup()
//        }


    func setControlsVisibility(_ visibility: Bool) {
        skipButton.isHidden = !visibility
    }
    
//    func setup(){
//        view = loadFromNib()
////        videoView
////        view.frame = bounds
////        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
//    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    func player() -> AVPlayer? {
        let playerLayer = layer as? AVPlayerLayer
        return playerLayer?.player
    }
    
    public func setPlayer(_ p: AVPlayer?) {
        let playerLayer = layer as? AVPlayerLayer
        playerLayer?.player = p
    }
    
    
    

//     func loadFromNib() -> UIView {
//        print("This is inside the IASNativeVideoView > loadFromNib")
//        return Bundle.main.loadNibNamed("IASNativeVideoView", owner: self, options: nil)?.first as? IASVideoView
////         
////         let bundle = Bundle(for: type(of: self))
////         let nib = UINib(nibName: "IASNativeVideoView", bundle: bundle)
////         let view = nib.instantiate(withOwner: self, options: nil)[0] as! IASVideoView
////         
////         addSubview(view)
////         
////         print(view);
////         return view as! UIView;
//    }
    
    class func loadFromNib() -> IASNativeVideoView? {
        return Bundle.main.loadNibNamed("IASNativeVideoView", owner: nil, options: nil)?.first as? IASNativeVideoView
    }


}

