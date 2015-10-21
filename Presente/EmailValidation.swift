//
//  EmailValidation.swift
//  Presente
//
//  Created by Jenny Yang on 10/20/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import Foundation

class EmailValidation: Validation {
    
    let EMAIL_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    
    func validate(value:String) -> (Bool, ValidationErrorType) {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
        
        if emailTest.evaluateWithObject(value) {
            return (true, .NoError)
        } else {
            return (false,.Email)
        }
        
        
    }
}