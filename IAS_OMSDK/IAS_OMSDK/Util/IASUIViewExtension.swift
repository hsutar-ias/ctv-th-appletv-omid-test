//
//  IASUIViewExtension.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 28/07/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//
import Foundation
import Foundation
/**
 - IASUIViewExtension is extension with ias_addConstraint and ias_addChild functions
 */
public extension UIView {
    func ias_addConstraint(toItem item: UIView?, attribute attr: NSLayoutConstraint.Attribute, constant: CGFloat) {
        if let item = item {
            addConstraint(
                NSLayoutConstraint(
                    item: item,
                    attribute: attr,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: attr,
                    multiplier: 1,
                    constant: constant))
        }
    }
    
    func ias_addConstraint(toItem item: UIView?, attribute attr: NSLayoutConstraint.Attribute) {
        ias_addConstraint(toItem: item, attribute: attr, constant: 0)
    }
    
    func ias_addConstraints(toItem item: UIView?) {
        ias_addConstraint(toItem: item, attribute: NSLayoutConstraint.Attribute.top)
        ias_addConstraint(toItem: item, attribute: NSLayoutConstraint.Attribute.bottom)
        ias_addConstraint(toItem: item, attribute: NSLayoutConstraint.Attribute.left)
        ias_addConstraint(toItem: item, attribute: NSLayoutConstraint.Attribute.right)
    }
    
    func ias_addChild(_ child: UIView?) {
        child?.translatesAutoresizingMaskIntoConstraints = false
        if let child = child {
            addSubview(child)
        }
        ias_addConstraints(toItem: child)
    }
}
