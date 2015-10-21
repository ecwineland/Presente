//
//  Validation.swift
//  Presente
//
//  Created by Jenny Yang on 10/20/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import Foundation

protocol Validation {
    func validate(value:String) -> (Bool, ValidationErrorType)
}