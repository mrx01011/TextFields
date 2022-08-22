//
//  PasswordStrengthType.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 18.08.2022.
//

import Foundation

enum StrengthType {
    case weak
    case medium
    case strong
    case veryStrong
}

public enum ValidationRequiredRule {
    case lowerCase
    case uppercase
    case digit
    case minmumLength
}
