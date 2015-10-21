//
//  PasswordValidation.swift
//  Presente
//
//  Created by Jenny Yang on 10/20/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import Foundation

class PasswordValidation : Validation {
    
    // 8 characters. One uppercase
    var PASSWORD_REGEX = "^(?=.*?[A-Z]).{8,}$"
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        let passwordTes = NSPredicate(format: "SELF MATCHES %@", PASSWORD_REGEX)
        
        if passwordTes.evaluateWithObject(value) {
            return (true, .NoError)
        }
        return (false, .Password)
        
        
    }
}