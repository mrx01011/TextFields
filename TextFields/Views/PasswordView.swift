//
//  PasswordView.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 29.08.2022.
//

import UIKit
import SnapKit

class PasswordView: UIView {
    //MARK: Password Strength Manager
    private let passwordStrengthManager = PasswordStrengthManager()
    //MARK: UIElements
    private let title: UILabel = {
        let label = UILabel()
        label.text = Constants.ValidationTitle.text
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let inputContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.backgroundColor = Constants.inputBackgroundColor
        view.layer.borderColor = Constants.inputBorderColor
        return view
    }()
    private let inputTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = Constants.PasswordInput.placeholder
        textfield.textColor = Constants.inputTextColor
        textfield.returnKeyType = .done
        textfield.textContentType = .password
        textfield.isSecureTextEntry = true
        return textfield
    }()
    private let passwordStrengthProgressView: UIProgressView = {
        let view = UIProgressView()
        view.progressViewStyle = .default
        view.trackTintColor = .white
        return view
    }()
    private let minLengthRuleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.RulesLabel.minLengthRule
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let minDigitRuleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.RulesLabel.minDigitRule
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let minLowercaseRuleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.RulesLabel.minLowercaseRule
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let minUppercaseRuleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.RulesLabel.minUppercaseRule
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    //MARK: Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
        defaultConfiguration()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupUI() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        addSubview(inputContentView)
        inputContentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(Constants.OffSet.textfieldViewTop)
            make.height.equalTo(Constants.OffSet.textfieldViewHeight)
        }
        inputContentView.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(inputContentView).inset(Constants.OffSet.inputLeading)
            make.top.bottom.equalTo(inputContentView).inset(Constants.OffSet.inputTop)
        }
        addSubview(passwordStrengthProgressView)
        passwordStrengthProgressView.snp.makeConstraints { make in
            make.top.equalTo(inputContentView.snp.bottom).offset(Constants.OffSet.PasswordStrengthProgressView.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.OffSet.PasswordStrengthProgressView.height)
        }
        addSubview(minLengthRuleLabel)
        minLengthRuleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(Constants.OffSet.RulesLabel.side)
            make.top.equalTo(passwordStrengthProgressView.snp.bottom).offset(Constants.OffSet.RulesLabel.top)
        }
        addSubview(minDigitRuleLabel)
        minDigitRuleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(Constants.OffSet.RulesLabel.side)
            make.top.equalTo(minLengthRuleLabel.snp.bottom).offset(Constants.OffSet.RulesLabel.spacing)
        }
        addSubview(minLowercaseRuleLabel)
        minLowercaseRuleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(Constants.OffSet.RulesLabel.side)
            make.top.equalTo(minDigitRuleLabel.snp.bottom).offset(Constants.OffSet.RulesLabel.spacing)
        }
        addSubview(minUppercaseRuleLabel)
        minUppercaseRuleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(Constants.OffSet.RulesLabel.side)
            make.top.equalTo(minLowercaseRuleLabel.snp.bottom).offset(Constants.OffSet.RulesLabel.spacing)
            make.bottom.equalToSuperview()
        }
    }
    
    private func defaultConfiguration() {
        backgroundColor = .white
        inputTextField.delegate = self
    }
    
    private func getProgressInfo(fromStrength strength: StrengthType) -> ProgressViewInformation {
        var color: UIColor
        var percentage: Float
        switch strength {
        case .veryStrong:
            percentage = 1.0
            color = strength.color
            
        case .strong:
            percentage = 0.75
            color = strength.color
            
        case .medium:
            percentage = 0.50
            color = strength.color
            
        case .weak:
            percentage = 0.25
            color = strength.color
        }
        return ProgressViewInformation(color: color, percentage: percentage)
    }
}
//MARK: Text Field Delegate
extension PasswordView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        inputContentView.layer.borderWidth = Constants.activeBorderWidth
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        inputContentView.layer.borderWidth = Constants.inactiveBorderWidth
        inputTextField.attributedPlaceholder = Constants.PasswordInput.placeholder
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        minLengthRuleLabel.textColor = Constants.titleTextColor
        minDigitRuleLabel.textColor = Constants.titleTextColor
        minLowercaseRuleLabel.textColor = Constants.titleTextColor
        minUppercaseRuleLabel.textColor = Constants.titleTextColor
        if !updatedText.isEmpty {
            let implementedRules = passwordStrengthManager.getFulfilledRules(from: updatedText)
            implementedRules.forEach { rule in
                switch rule {
                case .lowerCase:
                    minLowercaseRuleLabel.textColor = .green
                case .uppercase:
                    minUppercaseRuleLabel.textColor = .green
                case .digit:
                    minDigitRuleLabel.textColor = .green
                case .minLength:
                    minLengthRuleLabel.textColor = .green
                }
            }
            let strength = passwordStrengthManager.getPasswordStrength(containingRules: implementedRules)
            let progressInfo = getProgressInfo(fromStrength: strength)
            passwordStrengthProgressView.setProgress(progressInfo.percentage, animated: false)
            passwordStrengthProgressView.progressTintColor = progressInfo.color
        } else  {
            passwordStrengthProgressView.setProgress(0, animated: false)
        }
        return true
    }
}
