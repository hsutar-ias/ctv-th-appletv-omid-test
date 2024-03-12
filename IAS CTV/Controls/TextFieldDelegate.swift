//
//  TextFieldDelegate.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 11/07/23.
//

import Foundation
import UIKit

/**
 - This class is extended UITextFieldDelegate and override it's functions
 - Handled UITextfield delegate functions
 */
class TextFieldDelegate: NSObject, UITextFieldDelegate {
    var textFields: [UITextField]!
    var currentTextField: UITextField?
    
    init(withTextFields: [UITextField]) {
        super.init()
        textFields = withTextFields
        for (_, textField) in textFields.enumerated() {
            textField.delegate = self
        }
    }
    
    open func update() {
        
    }
    
    @discardableResult open func endEditing() -> Bool {
        if !(currentTextField != nil) {
            return true
        }
        if textFieldShouldEndEditing(currentTextField!) {
            currentTextField!.resignFirstResponder()
            return true
        }
        return false
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    open func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        currentTextField = nil
        
    }
    
    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
