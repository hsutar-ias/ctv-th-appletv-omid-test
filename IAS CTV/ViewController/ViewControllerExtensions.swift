//
//  ViewControllerExtensions.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 18/07/23.

import Foundation
import UIKit

/**
 - ViewControllerExtensions used for creating a extension for adding Constraint
 */
extension UIView {
    func addConstraint(toItem item: UIView?, attribute attr: NSLayoutConstraint.Attribute, constant: CGFloat) {
        addConstraint(
            NSLayoutConstraint(
                item: item!,
                attribute: attr,
                relatedBy: .equal,
                toItem: self,
                attribute: attr,
                multiplier: 1,
                constant: constant))
    }
    
    func addConstraint(toItem item: UIView?, attribute attr: NSLayoutConstraint.Attribute) {
        addConstraint(toItem: item, attribute: attr, constant: 0)
    }
}
