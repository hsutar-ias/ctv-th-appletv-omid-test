//
//  AdSource.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 11/07/23.
//

import Foundation
import UIKit
/**
 AdSource is a protocol with have some properties and functions for ad view
 */
protocol AdSource {
    var adView: UIView? { get }
//    var adWebView: UIView? { get }
    var adVisibility: String? { get }
    var index: Int { get set }
    var shouldBeHidden: Bool { get set }
    init(controller: UIViewController?)
    
    func viewWillAppear()
    
    func viewWillDisappear()
    
    func finishSession()
    
    func cleanup()
}

