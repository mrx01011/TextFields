//
//  NoDigitsManager.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 30.08.2022.
//

import Foundation

class NoDigitsManager {
    func isNoDigit(inString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits.inverted
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
