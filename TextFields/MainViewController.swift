//
//  MainViewController.swift
//  TextFields
//
//  Created by Vladyslav Nhuien on 05.08.2022.
//
import SnapKit
import UIKit

final class MainViewController: UIViewController {
    //MARK: UIElements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let topSafeAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Header.text
        label.font = Constants.Header.font
        label.textColor = Constants.Header.textColor
        label.textAlignment = .center
        return label
    }()
    private let noDigitsView = NoDigitsView()
    private let limitView = LimitView()
    private let onlyCharView = OnlyCharView()
    private let linkView = LinkView()
    private let passwordView = PasswordView()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        defaultConfiguration()
        observeKeyboardNotificaton()
        addTapToHideKeyboard()
    }
    //MARK: Methods
    private func addTapToHideKeyboard() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard(gesture:))
        )
        contentView.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        //Top safe area
        view.addSubview(topSafeAreaView)
        topSafeAreaView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.TopSafeArea.side)
            make.top.equalToSuperview().inset(Constants.OffSet.TopSafeArea.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        //Scroll view
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(topSafeAreaView.snp.bottom)
            make.bottomMargin.equalToSuperview()
        }
        //Content view
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        //Header view
        contentView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.OffSet.side)
            make.top.equalTo(contentView.snp.top).offset(Constants.OffSet.Header.top)
        }
        //No digits view
        contentView.addSubview(noDigitsView)
        noDigitsView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.OffSet.side)
            make.top.equalTo(headerLabel.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Limit view
        contentView.addSubview(limitView)
        limitView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.OffSet.side)
            make.top.equalTo(noDigitsView.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Only character view
        contentView.addSubview(onlyCharView)
        onlyCharView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.OffSet.side)
            make.top.equalTo(limitView.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Link view
        contentView.addSubview(linkView)
        linkView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.OffSet.side)
            make.top.equalTo(onlyCharView.snp.bottom).offset(Constants.OffSet.labelTop)
        }
        //Password view
        contentView.addSubview(passwordView)
        passwordView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.OffSet.side)
            make.top.equalTo(linkView.snp.bottom).offset(Constants.OffSet.labelTop)
        }
    }
    
    private func defaultConfiguration() {
        contentView.backgroundColor = .white
        view.backgroundColor = .white
    }
}
//MARK: Keyboard
extension MainViewController {
    private func observeKeyboardNotificaton() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(sender:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(sender:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo else { return }
        guard var keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(sender: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc private func hideKeyboard(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
