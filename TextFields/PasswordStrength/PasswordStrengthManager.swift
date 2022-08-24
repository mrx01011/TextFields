//
//  PasswordStrengthManager.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 18.08.2022.
//

import UIKit

class PasswordStrengthManager {
    var strength: StrengthType = .weak
    
    func getValidationRules(password: String) -> Set<ValidationRequiredRule> {
        let rules = PasswordRules.passwordRule
        let minLength = PasswordRules.minPasswordLength
        var validationCompletion: Set<ValidationRequiredRule> = []
        
        if password.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil {
            validationCompletion.insert(.lowerCase)
        }
        if password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil {
            validationCompletion.insert(.uppercase)
        }
        if password.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
            validationCompletion.insert(.digit)
        }
        if password.count >= minLength {
            validationCompletion.insert(.minLength)
        }
        strength = strengthCheck(requiredRule: rules, containingRule: validationCompletion)
        
        return validationCompletion
    }
    func strengthCheck(requiredRule: Set<ValidationRequiredRule>, containingRule: Set<ValidationRequiredRule>) -> StrengthType {
        if containingRule.count == requiredRule.count - 2 {
            return .medium
        } else if containingRule.count == requiredRule.count - 1 {
            return .strong
        } else if containingRule.count == requiredRule.count {
            return .veryStrong
        } else {
            return .weak
        }
    }
}
