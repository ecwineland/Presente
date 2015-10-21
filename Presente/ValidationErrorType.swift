//
//  ValidationErrorType.swift
//  Presente
//
//  Created by Jenny Yang on 10/20/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import Foundation

enum ValidationErrorType {
    case Required,
    Email,
    Password,
    MinLength,
    MaxLength,
    ZipCode,
    PhoneNumber,
    FullName,
    NoError
    
    func description() -> String {
        switch self {
        case .Required:
            return "Required field"
        case .Email:
            return "Must be a valid email"
        case .MaxLength:
            return "This field should be less than"
        case .ZipCode:
            return "5 digit zipcode"
        case .PhoneNumber:
            return "10 digit phone number"
        case .Password:
            return "Must be at least 8 characters"
        case .FullName:
            return "Provide a first & last name"
        default:
            return ""
        }
    }
    
}