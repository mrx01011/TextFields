//
//  PasswordRules.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 18.08.2022.
//

import UIKit

public class PasswordRules {
    public static var passwordRule: [ValidationRequiredRule] = [.lowerCase, .digit, .minmumLength, .uppercase]
    
    public static var weakStrengthColor: UIColor = .red
    public static var mediumStrengthColor: UIColor = .orange
    public static var strongStrengthColor: UIColor = .yellow
    public static var veryStrongStrengthColor: UIColor = .green
    
    public static var minPasswordLength: Int = 8
}
