//
//  PasswordRules.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 18.08.2022.
//

import UIKit

enum PasswordRules {
    static let passwordRule: Set<ValidationRequiredRule> = ValidationRequiredRule
    static let minPasswordLength: Int = 8
}

enum ValidationRequiredRule {
    case lowerCase
    case uppercase
    case digit
    case minLength
}
