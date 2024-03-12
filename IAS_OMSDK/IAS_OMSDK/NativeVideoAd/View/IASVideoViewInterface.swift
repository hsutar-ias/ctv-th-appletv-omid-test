//
//  IASVideoViewInterface.swift
//  IASOMID_SDK
//
//  Created by Archana Deshmukh on 01/08/23.
//  Copyright © 2023 Akshay Patil. All rights reserved.
//

import Foundation

protocol IASVideoViewInterface: NSObjectProtocol {
    var delegate: IASVideoDelegate? { get set }
    var videoView: IASVideoView? { get }
    var mainView: UIView? { get }
    func setControlsVisibility(_ visibility: Bool)
}
