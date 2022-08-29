//
//  File.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 29.08.2022.
//

import UIKit
import SnapKit

class LimitView: UIView {
    //MARK: UIElements
    private let title: UILabel = {
        let label = UILabel()
        label.text = Constants.InputLimitTitle.text
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let limitLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.LimitLabel.emptyText
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
        textfield.attributedPlaceholder = Constants.InputLimit.placeholder
        textfield.textColor = Constants.inputTextColor
        textfield.returnKeyType = .done
        return textfield
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
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        addSubview(limitLabel)
        limitLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        addSubview(inputContentView)
        inputContentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(Constants.OffSet.textfieldViewTop)
            make.height.equalTo(Constants.OffSet.textfieldViewHeight)
        }
        inputContentView.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(inputContentView).inset(Constants.OffSet.inputLeading)
            make.top.bottom.equalTo(inputContentView).inset(Constants.OffSet.inputTop)
        }
    }
    
    private func defaultConfiguration() {
        backgroundColor = .white
        inputTextField.delegate = self
    }
}
//MARK: Text Field Delegate
extension LimitView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        inputContentView.layer.borderWidth = Constants.activeBorderWidth
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.attributedPlaceholder = Constants.InputLimit.placeholder
        inputContentView.layer.borderWidth = Constants.inactiveBorderWidth
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let lngthToAdd = updatedText.count
        limitLabel.text = "\(Constants.InputLimit.charLimit - lngthToAdd)/10"
        if lngthToAdd <= Constants.InputLimit.charLimit {
            limitLabel.textColor = Constants.titleTextColor
            inputContentView.layer.borderColor = Constants.inputBorderColor
        } else {
            limitLabel.textColor = .red
            inputContentView.layer.borderColor = UIColor.red.cgColor
        }
        return true
    }
}
