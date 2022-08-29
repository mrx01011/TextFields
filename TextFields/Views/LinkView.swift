//
//  LinkView.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 29.08.2022.
//

import UIKit
import SnapKit
import SafariServices

class LinkView: UIView {
    //MARK: UIElements
    private let title: UILabel = {
        let label = UILabel()
        label.text = Constants.LinkTitle.text
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
        textfield.attributedPlaceholder = Constants.LinkInput.placeholder
        textfield.textColor = Constants.inputTextColor
        textfield.returnKeyType = .go
        return textfield
    }()
    //MARK: Timer
    weak private var timer: Timer?
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
    
    private func tryOpen(urlFromString string: String) {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard let strongDetector = detector,
              !string.isEmpty,
              strongDetector.numberOfMatches(
                in: string,
                options: NSRegularExpression.MatchingOptions(rawValue: 0),
                range: NSMakeRange(0, string.count)
              ) > 0 else { return }
        
        var protocoledString = string
        if !protocoledString.contains(Constants.LinkInput.thing) {
            protocoledString = Constants.LinkInput.linkProtocol + protocoledString
        }
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            if let url = URL(string: protocoledString) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
            }
        }
    }
}
//MARK: Text Field Delegate
extension LinkView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        inputContentView.layer.borderWidth = Constants.activeBorderWidth
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.attributedPlaceholder = Constants.LinkInput.placeholder
        inputContentView.layer.borderWidth = Constants.inactiveBorderWidth
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tryOpen(urlFromString: textField.text ?? "")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        tryOpen(urlFromString: updatedText)
        return true
    }
}
