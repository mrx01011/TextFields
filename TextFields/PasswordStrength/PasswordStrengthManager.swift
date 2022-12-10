//
//  PasswordStrengthManager.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 18.08.2022.
//

import UIKit

class PasswordStrengthManager {
    
    func getFulfilledRules(from password: String) -> Set<ValidationRequiredRule> {
        let minLength = PasswordRules.minPasswordLength
        var validationRules = Set<ValidationRequiredRule>()
        
        if password.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil {
            validationRules.insert(.lowerCase)
        }
        if password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil {
            validationRules.insert(.uppercase)
        }
        if password.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
            validationRules.insert(.digit)
        }
        if password.count >= minLength {
            validationRules.insert(.minLength)
        }
        
        return validationRules
    }
    
    func getPasswordStrength(requiredRules: Set<ValidationRequiredRule> = PasswordRules.passwordRule, containingRules: Set<ValidationRequiredRule>) -> StrengthType {
        if containingRules.count == requiredRules.count - 2 {
            return .medium
        } else if containingRules.count == requiredRules.count - 1 {
            return .strong
        } else if containingRules.count == requiredRules.count {
            return .veryStrong
        } else {
            return .weak
        }
    }
}
