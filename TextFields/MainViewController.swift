//
//  MainViewController.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 05.08.2022.
//
import SnapKit
import UIKit
import JMMaskTextField_Swift
import SafariServices

class MainViewController: UIViewController {
    //MARK: Timer
    weak private var timer: Timer?
    //MARK: UIElements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let topSafeAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let header: UILabel = {
        let label = UILabel()
        label.text = Constants.Header.text
        label.font = Constants.Header.font
        label.textColor = Constants.Header.textColor
        label.textAlignment = .center
        return label
    }()
    private let nodigitsTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.NodigitsTitle.text
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let nodigitsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.backgroundColor = Constants.inputBackgroundColor
        view.layer.borderColor = Constants.inputBorderColor
        return view
    }()
    private let nodigitsInput: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = Constants.NodigitsInput.placeholder
        textfield.textColor = Constants.inputTextColor
        textfield.returnKeyType = .done
        return textfield
    }()
    private let inputLimitTitle: UILabel = {
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
    private let limitView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.backgroundColor = Constants.inputBackgroundColor
        view.layer.borderColor = Constants.inputBorderColor
        return view
    }()
    private let limitInput: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = Constants.InputLimit.placeholder
        textfield.textColor = Constants.inputTextColor
        textfield.returnKeyType = .done
        return textfield
    }()
    private let onlyCharTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.OnlyCharTitle.text
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let onlyCharView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.backgroundColor = Constants.inputBackgroundColor
        view.layer.borderColor = Constants.inputBorderColor
        return view
    }()
    private let onlyCharInput: JMMaskTextField = {
        let textfield = JMMaskTextField()
        textfield.attributedPlaceholder = Constants.OnlyCharInput.placeholder
        textfield.textColor = Constants.inputTextColor
        textfield.returnKeyType = .done
        textfield.maskString = Constants.OnlyCharInput.mask
        return textfield
    }()
    private let linkTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.LinkTitle.text
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let linkView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.backgroundColor = Constants.inputBackgroundColor
        view.layer.borderColor = Constants.inputBorderColor
        return view
    }()
    private let linkInput: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = Constants.LinkInput.placeholder
        textfield.textColor = Constants.inputTextColor
        textfield.returnKeyType = .go
        return textfield
    }()
    private let validationTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.ValidationTitle.text
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let passwordView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.backgroundColor = Constants.inputBackgroundColor
        view.layer.borderColor = Constants.inputBorderColor
        return view
    }()
    private let passwordInput: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = Constants.PasswordInput.placeholder
        textfield.textColor = Constants.inputTextColor
        textfield.returnKeyType = .done
        textfield.textContentType = .password
        textfield.isSecureTextEntry = true
        return textfield
    }()
    private let passwordStrength: UIProgressView = {
        let view = UIProgressView()
        view.progressViewStyle = .default
        view.trackTintColor = .white
        return view
    }()
    private let minLengthRule: UILabel = {
        let label = UILabel()
        label.text = Constants.RulesLabel.minLengthRule
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let minDigitRule: UILabel = {
        let label = UILabel()
        label.text = Constants.RulesLabel.minDigitRule
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let minLowercaseRule: UILabel = {
        let label = UILabel()
        label.text = Constants.RulesLabel.minLowercaseRule
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    private let minUppercaseRule: UILabel = {
        let label = UILabel()
        label.text = Constants.RulesLabel.minUppercaseRule
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        return label
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        defaultConfiguration()
        observeKeyboardNotificaton()
        addTapGesture()
    }
    //MARK: Methods
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        contentView.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        // Top safe area
        view.addSubview(topSafeAreaView)
        topSafeAreaView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.TopSafeArea.side)
            make.top.equalToSuperview().inset(Constants.OffSet.TopSafeArea.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        // Scroll view
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(topSafeAreaView.snp.bottom)
            make.bottomMargin.equalToSuperview()
        }
        // Content view
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        // Header view
        contentView.addSubview(header)
        header.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(contentView.snp.top).offset(Constants.OffSet.Header.top)
        }
        // No digits label
        contentView.addSubview(nodigitsTitle)
        nodigitsTitle.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.OffSet.side)
            make.top.equalTo(header.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Nodigits textfield
        contentView.addSubview(nodigitsView)
        nodigitsView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(nodigitsTitle.snp.bottom).offset(Constants.OffSet.textfieldViewTop)
            make.height.equalTo(Constants.OffSet.textfieldViewHeight)
        }
        nodigitsView.addSubview(nodigitsInput)
        nodigitsInput.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nodigitsView.safeAreaLayoutGuide).inset(Constants.OffSet.inputLeading)
            make.top.equalTo(nodigitsView.snp.top).offset(Constants.OffSet.inputTop)
        }
        //Input label
        contentView.addSubview(inputLimitTitle)
        inputLimitTitle.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.OffSet.side)
            make.top.equalTo(nodigitsView.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Limit label
        contentView.addSubview(limitLabel)
        limitLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(nodigitsView.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Input limit
        contentView.addSubview(limitView)
        limitView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(inputLimitTitle.snp.bottom).offset(Constants.OffSet.textfieldViewTop)
            make.height.equalTo(Constants.OffSet.textfieldViewHeight)
        }
        limitView.addSubview(limitInput)
        limitInput.snp.makeConstraints { make in
            make.leading.trailing.equalTo(limitView.safeAreaLayoutGuide).inset(Constants.OffSet.inputLeading)
            make.top.equalTo(limitView.snp.top).offset(Constants.OffSet.inputTop)
        }
        //Only characters label
        contentView.addSubview(onlyCharTitle)
        onlyCharTitle.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.OffSet.side)
            make.top.equalTo(limitView.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Only characters input
        contentView.addSubview(onlyCharView)
        onlyCharView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(onlyCharTitle.snp.bottom).offset(Constants.OffSet.textfieldViewTop)
            make.height.equalTo(Constants.OffSet.textfieldViewHeight)
        }
        onlyCharView.addSubview(onlyCharInput)
        onlyCharInput.snp.makeConstraints { make in
            make.leading.trailing.equalTo(onlyCharView.safeAreaLayoutGuide).inset(Constants.OffSet.inputLeading)
            make.top.equalTo(onlyCharView.snp.top).offset(Constants.OffSet.inputTop)
        }
        //Link label
        contentView.addSubview(linkTitle)
        linkTitle.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.OffSet.side)
            make.top.equalTo(onlyCharView.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Link input
        contentView.addSubview(linkView)
        linkView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(linkTitle.snp.bottom).offset(Constants.OffSet.textfieldViewTop)
            make.height.equalTo(Constants.OffSet.textfieldViewHeight)
        }
        linkView.addSubview(linkInput)
        linkInput.snp.makeConstraints { make in
            make.leading.trailing.equalTo(linkView.safeAreaLayoutGuide).inset(Constants.OffSet.inputLeading)
            make.top.equalTo(linkView.snp.top).offset(Constants.OffSet.inputTop)
        }
        //Validation label
        contentView.addSubview(validationTitle)
        validationTitle.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.OffSet.side)
            make.top.equalTo(linkView.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Password input
        contentView.addSubview(passwordView)
        passwordView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(validationTitle.snp.bottom).offset(Constants.OffSet.textfieldViewTop)
            make.height.equalTo(Constants.OffSet.textfieldViewHeight)
        }
        passwordView.addSubview(passwordInput)
        passwordInput.snp.makeConstraints { make in
            make.leading.trailing.equalTo(passwordView.safeAreaLayoutGuide).inset(Constants.OffSet.inputLeading)
            make.top.equalTo(passwordView.snp.top).offset(Constants.OffSet.inputTop)
        }
        //Password strength checker
        contentView.addSubview(passwordStrength)
        passwordStrength.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(passwordView.snp.bottom).offset(3)
            make.height.equalTo(4)
        }
        //Rules labels
        contentView.addSubview(minLengthRule)
        minLengthRule.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.OffSet.RulesLabel.side)
            make.top.equalTo(passwordStrength.snp.bottom).offset(Constants.OffSet.RulesLabel.top)
        }
        contentView.addSubview(minDigitRule)
        minDigitRule.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.OffSet.RulesLabel.side)
            make.top.equalTo(minLengthRule.snp.bottom).offset(Constants.OffSet.RulesLabel.spacing)
        }
        contentView.addSubview(minLowercaseRule)
        minLowercaseRule.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.OffSet.RulesLabel.side)
            make.top.equalTo(minDigitRule.snp.bottom).offset(Constants.OffSet.RulesLabel.spacing)
        }
        contentView.addSubview(minUppercaseRule)
        minUppercaseRule.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.OffSet.RulesLabel.side)
            make.top.equalTo(minLowercaseRule.snp.bottom).offset(Constants.OffSet.RulesLabel.spacing)
        }
    }
    
    private func defaultConfiguration() {
        contentView.backgroundColor = .white
        view.backgroundColor = .white
        nodigitsInput.delegate = self
        limitInput.delegate = self
        onlyCharInput.delegate = self
        linkInput.delegate = self
        passwordInput.delegate = self
    }
    
    private func observeKeyboardNotificaton() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func verifyUrl (string: String) -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && string.count > 0) else { return false }
        if detector!.numberOfMatches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, string.count)) > 0 {
            return true
        }
        return false
    }
    
    private func search(url: String) {
        var string = url
        if !string.contains(Constants.LinkInput.thing) {
            string = Constants.LinkInput.linkProtocol + string
        }
        timer = .scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] timer in
            if let url = URL(string: string) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                self?.present(vc, animated: true)
            }
        }
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(sender: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
//MARK: Textfield Delegate
extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        switch textField {
        case nodigitsInput:
            nodigitsView.layer.borderWidth = Constants.activeBorderWidth
        case limitInput:
            limitView.layer.borderWidth = Constants.activeBorderWidth
        case onlyCharInput:
            onlyCharView.layer.borderWidth = Constants.activeBorderWidth
        case linkInput:
            linkView.layer.borderWidth = Constants.activeBorderWidth
        case passwordInput:
            passwordView.layer.borderWidth = Constants.activeBorderWidth
        default:
            break
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nodigitsInput:
            nodigitsView.layer.borderWidth = Constants.inactiveBorderWidth
            nodigitsInput.attributedPlaceholder = Constants.NodigitsInput.placeholder
        case limitInput:
            limitView.layer.borderWidth = Constants.inactiveBorderWidth
            limitInput.attributedPlaceholder = Constants.InputLimit.placeholder
        case onlyCharInput:
            onlyCharView.layer.borderWidth = Constants.inactiveBorderWidth
            onlyCharInput.attributedPlaceholder = Constants.OnlyCharInput.placeholder
        case linkInput:
            linkView.layer.borderWidth = Constants.inactiveBorderWidth
            linkInput.attributedPlaceholder = Constants.LinkInput.placeholder
        case passwordInput:
            passwordView.layer.borderWidth = Constants.inactiveBorderWidth
            passwordInput.attributedPlaceholder = Constants.PasswordInput.placeholder
        default:
            break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        if textField == linkInput {
            let isUrl = verifyUrl(string: textField.text ?? "")
            if isUrl {
                search(url: textField.text ?? "")
            }
        } else {
            return false
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        switch textField {
        case nodigitsInput:
            let allowedCharacters = CharacterSet.decimalDigits.inverted
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        case limitInput:
            let lngthToAdd = updatedText.count
            limitLabel.text = "\(Constants.InputLimit.charLimit - lngthToAdd)/10"
            if lngthToAdd <= Constants.InputLimit.charLimit {
                limitLabel.textColor = Constants.titleTextColor
                limitView.layer.borderColor = Constants.inputBorderColor
            } else {
                limitLabel.textColor = .red
                limitView.layer.borderColor = UIColor.red.cgColor
            }
            
        case linkInput:
            timer?.invalidate()
            let isUrl = verifyUrl(string: textField.text ?? "")
            if isUrl {
                search(url: textField.text ?? "")
            } else {
                break
            }
        case passwordInput:
            minLengthRule.textColor = Constants.titleTextColor
            minDigitRule.textColor = Constants.titleTextColor
            minLowercaseRule.textColor = Constants.titleTextColor
            minUppercaseRule.textColor = Constants.titleTextColor
            if !updatedText.isEmpty {
                let validationId = PasswordStrengthManager.checkValidation(password: updatedText, rules: PasswordRules.passwordRule, minLength: PasswordRules.minPasswordLength)
                let progressInfo = PasswordStrengthManager.setProgressView(strength: validationId.strength)
                passwordStrength.setProgress(progressInfo.percentage, animated: false)
                passwordStrength.progressTintColor = progressInfo.color
                if updatedText.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil {
                    minLowercaseRule.textColor = .green
                }
                if updatedText.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil {
                    minUppercaseRule.textColor = .green
                }
                if updatedText.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                    minDigitRule.textColor = .green
                }
                
                if updatedText.count >= Constants.PasswordRules.minLength {
                    minLengthRule.textColor = .green
                }
            } else  {
                passwordStrength.setProgress(0, animated: false)
            }
        default:
            break
        }
        return true
    }
}
//MARK: Constants
extension MainViewController {
    private enum Constants {
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
                static let side: CGFloat = 24
                static let top: CGFloat = 8
                static let spacing: CGFloat = 5
            }
        }
    }
}
