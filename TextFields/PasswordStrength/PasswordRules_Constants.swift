//
//  PasswordRules.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 18.08.2022.
//

import UIKit

enum PasswordRules {
    static let passwordRule = Set<ValidationRequiredRule>(ValidationRequiredRule.allCases)
    static let minPasswordLength: Int = 8
}

