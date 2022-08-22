//
//  PasswordStrengthManager.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 18.08.2022.
//

import UIKit

struct PasswordStateInfo {
    var allRequirementDone: Bool = false
    var strength: StrengthType = .weak
}

struct ProgressViewInformation {
    var color: UIColor = .white
    var percentage: Float = 0.0
}

public class PasswordStrengthManager {
    
    class func setProgressView(strength: StrengthType) -> ProgressViewInformation {
        
        var progressStruct = ProgressViewInformation()
        
        switch strength {
        case .veryStrong:
            progressStruct.percentage = 1.0
            progressStruct.color = PasswordRules.veryStrongStrengthColor
        case .strong:
            progressStruct.percentage = 0.75
            progressStruct.color = PasswordRules.strongStrengthColor
        case .medium:
            progressStruct.percentage = 0.50
            progressStruct.color = PasswordRules.mediumStrengthColor
        case .weak:
            progressStruct.percentage = 0.25
            progressStruct.color = PasswordRules.weakStrengthColor
        }
        
        return progressStruct
    }
    
    class func checkValidation(password: String, rules: [ValidationRequiredRule], minLength: Int) -> PasswordStateInfo {
        var returnModel = PasswordStateInfo()
        let rule: [ValidationRequiredRule] = rules
        let minLength = minLength
        var validationCompletion: [ValidationRequiredRule] = []
        
        if password.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil {
            validationCompletion.append(.lowerCase)
        }
        if password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil {
            validationCompletion.append(.uppercase)
        }
        if password.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
            validationCompletion.append(.digit)
        }
        if password.count >= minLength {
            validationCompletion.append(.minmumLength)
        }
        if rule.count == validationCompletion.count {
            returnModel.allRequirementDone = true
        }
        returnModel.strength = strengthChecker(requiredRule: rule, containingRule: validationCompletion)
        returnModel.allRequirementDone = isRequiredRuleInputed(requiredRule: rule, containingRule: validationCompletion)
        
        return returnModel
    }
    
    class func strengthChecker(requiredRule: [ValidationRequiredRule], containingRule: [ValidationRequiredRule]) -> StrengthType {
        if containingRule.count == 2 {
            return .medium
        } else if containingRule.count == 3 {
            return .strong
        } else if containingRule.count == requiredRule.count {
            return .veryStrong
        } else {
            return .weak
        }
    }
    
    class func isRequiredRuleInputed(requiredRule: [ValidationRequiredRule], containingRule: [ValidationRequiredRule]) -> Bool {
        var requirementFullFill: Bool = false
        if requiredRule.count == containingRule.count {
            requirementFullFill = true
        }
        
        return requirementFullFill
    }
}
