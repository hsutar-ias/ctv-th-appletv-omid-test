//
//  AdFactory.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 18/07/23.
//

import Foundation
import UIKit

/**
 - AdFactory class is used for geting ad source, hidden ad source, and no ad view hidden ad source
 */
class AdFactory {
    static let sharedFactory = AdFactory()
    
    func getAdSource(with controller: UIViewController?) -> AdSource? {
        let adSource = Config.sharedConfig.sdkProvider.createAdSource(with: controller)
        return adSource
    }

}
