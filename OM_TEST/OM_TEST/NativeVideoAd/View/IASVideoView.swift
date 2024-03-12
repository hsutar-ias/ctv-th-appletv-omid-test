//
//  IASVideoView.swift
//  IAS_OMSDK
//
//  Created by Archana Deshmukh on 02/08/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
/**
- IASVideoView class extends UIView
- This class is used for setting a video player
*/
class IASVideoView: UIView {

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
}
