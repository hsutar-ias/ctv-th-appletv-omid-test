//
//  PartnerNameTextFieldDelegate.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 11/07/23.
//

import Foundation
import UIKit
/**
- This class is extended base class TextFieldDelegate and override it's functions
- Handled partner text field delegate functions
*/
class PartnerNameTextFieldDelegate: TextFieldDelegate {
    override func update() {
        for (_ , textField) in self.textFields.enumerated() {
            if !(textField.isFirstResponder ) {
                let partnerName = Config.sharedConfig.partnerName
                textField.text = partnerName()
            }
        }
    }
    
    override func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        Config.sharedConfig.customPartnerName = textField.text
        super.textFieldDidEndEditing(textField)
    }
    
    var isValid: Bool {
        var isValid = true
        if Config.sharedConfig.adPartnerName == Config.AdPartnerName.kIASPartner {
            return isValid
        }
        for (_ , textField) in self.textFields.enumerated() {
            if (textField as AnyObject).text == "" {
                isValid = false
            }
        }
        return isValid
    }
}
