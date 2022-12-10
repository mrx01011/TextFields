//
//  OnlyCharView.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 29.08.2022.
//

import UIKit
import SnapKit
import JMMaskTextField_Swift

class OnlyCharView: UIView {
    //MARK: UIElements
    private let title: UILabel = {
        let label = UILabel()
        label.text = Constants.OnlyCharTitle.text
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
    private let inputTextField: JMMaskTextField = {
        let textfield = JMMaskTextField()
        textfield.attributedPlaceholder = Constants.OnlyCharInput.placeholder
        textfield.textColor = Constants.inputTextColor
        textfield.returnKeyType = .done
        textfield.maskString = Constants.OnlyCharInput.mask
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
            make.leading.trailing.top.equalToSuperview()
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
extension OnlyCharView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        inputContentView.layer.borderWidth = Constants.activeBorderWidth
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.attributedPlaceholder = Constants.OnlyCharInput.placeholder
        inputContentView.layer.borderWidth = Constants.inactiveBorderWidth
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
}
