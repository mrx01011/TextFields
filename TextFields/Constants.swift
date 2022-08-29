//
//  Constants.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 29.08.2022.
//

import UIKit

enum Constants {
    static let cornerRadius: CGFloat = 10
    static let titleFont = UIFont(name: "Rubik-Regular", size: 13) ?? UIFont.systemFont(ofSize: 13)
    static let titleTextColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
    static let inputTextColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 1)
    static let inputBackgroundColor = UIColor(red: 0.463, green: 0.463, blue: 0.502, alpha: 0.12).cgColor
    static let inputBorderColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
    static let inactiveBorderWidth: CGFloat = 0
    static let activeBorderWidth: CGFloat = 1
    enum Header {
        static let text = "Text Fields"
        static let font = UIFont(name: "Rubik-Medium", size: 34) ?? UIFont.systemFont(ofSize: 34)
        static let textColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
    }
    enum NodigitsTitle {
        static let text = "NO digits field"
    }
    enum NodigitsInput {
        static let placeholder =  NSAttributedString(
            string: "Type here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6), NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)])
    }
    enum InputLimitTitle {
        static let text = "Input limit"
    }
    enum LimitLabel {
        static let emptyText = "10/10"
    }
    enum InputLimit {
        static let placeholder =  NSAttributedString(
            string: "Type here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6), NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)])
        static let charLimit = 10
    }
    enum OnlyCharTitle {
        static let text = "Only characters"
    }
    enum OnlyCharInput {
        static let mask = "AAAAA-00000"
        static let placeholder =  NSAttributedString(
            string: "wwwww-ddddd",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6), NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)])
    }
    enum LinkTitle {
        static let text = "Link"
    }
    enum LinkInput {
        static let placeholder =  NSAttributedString(
            string: "www.example.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6), NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)])
        static let thing = "://"
        static let linkProtocol = "https://"
    }
    enum ValidationTitle {
        static let text = "Validation rules"
    }
    enum PasswordInput {
        static let placeholder =  NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6), NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)])
    }
    enum RulesLabel {
        static let minLengthRule = "Min length 8 characters"
        static let minDigitRule = "Min 1 digit"
        static let minLowercaseRule = "Min 1 lowercase"
        static let minUppercaseRule = "Min 1 uppercase"
    }
    enum PasswordRules {
        static let minLength = 8
    }
    enum OffSet {
        static let side: CGFloat = 16
        static let labelTop: CGFloat = 30
        static let textfieldViewTop: CGFloat = 4
        static let textfieldViewHeight: CGFloat = 36
        static let inputLeading: CGFloat = 8
        static let inputTop: CGFloat = 7
        enum TopSafeArea {
            static let side: CGFloat = 0
            static let top: CGFloat = 0
        }
        enum Header {
            static let top: CGFloat = 46
        }
        enum RulesLabel {
            static let side: CGFloat = 8
            static let top: CGFloat = 8
            static let spacing: CGFloat = 5
        }
        enum PasswordStrengthProgressView {
            static let top: CGFloat = 3
            static let height: CGFloat = 4
        }
    }
}
