//
//  PasswordStrengthType.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 18.08.2022.
//

import Foundation
import UIKit

enum StrengthType {
    case weak
    case medium
    case strong
    case veryStrong
    
    var color: UIColor {
        switch self {
        case .weak:
            return .red
        case .medium:
            return .orange
        case .strong:
            return .yellow
        case .veryStrong:
            return .green
        }
    }
}
