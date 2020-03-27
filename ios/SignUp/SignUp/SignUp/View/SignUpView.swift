//
//  SignUpCustomView.swift
//  SignUp
//
//  Created by Cloud on 2020/03/25.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit



final class SignUpView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idetnfierStatusLabel: UILabel!
    @IBOutlet weak var passwordStatusLabel: UILabel!
    @IBOutlet weak var confirmPasswordStatusLabel: UILabel!
    @IBOutlet weak var nameStatusLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Properties
    private var confirmStatus: Status = (false, false, false ,false) {
        didSet {
            NotificationCenter
                .default
                .post(
                    name: Notification.Name.postEnabledButton,
                    object: nil,
                    userInfo: ["status": confirmStatus]
            )
        }
    }
    
    // MARK: - Lifecycles
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addObserver()
    }
    
    deinit {
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: Notification.Name.identifier,
                object: nil
        )
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: Notification.Name.password,
                object: nil
        )
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: Notification.Name.isEnabledButton,
                object: nil
        )
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: Notification.Name.confirmPassword,
                object: nil
        )
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: Notification.Name.name,
                object: nil
        )
    }
    
    // MARK: - IBActions
    @IBAction func gestureAction(_ sender: Any) {
        endEditing(true)
    }
    
    // MARK: - Methods
    private func addObserver() {
        addObserverIdentifier()
        addObserverPassword()
        addObserverConfirmPassword()
        addObserverName()
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(isEnabledNextButton),
                name: Notification.Name.isEnabledButton,
                object: nil
        )
    }
    
    private func addObserverIdentifier() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(passwordTextFieldBecomeFirstResponder),
                name: Notification.Name.identifier,
                object: nil
        )
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(applyRegularExpressionWithIdentifier),
                name: Notification.Name.regularExpressionWithIdentifier,
                object: nil
        )
    }
    
    private func addObserverPassword() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(confirmPasswordTextFieldBecomFirstResponder),
                name: Notification.Name.password,
                object: nil
        )
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(applyRegularExpressionWithPassword),
                name: Notification.Name.regularExpressionWithPassword,
                object: nil
        )
    }
    
    private func addObserverConfirmPassword() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(nameTextFieldBecomeFirstResponder),
                name: Notification.Name.confirmPassword,
                object: nil
        )
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(postPassword),
                name: Notification.Name.fetchPassword,
                object: nil
        )
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(comparePassword),
                name: Notification.Name.comparePasswords,
                object: nil
        )
    }
    
    private func addObserverName() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(nameTextFieldResignFirstResponder),
                name: Notification.Name.name,
                object: nil
        )
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(isEmptyNameTextField),
                name: Notification.Name.isEmptyName,
                object: nil
        )
    }
    
    private func checkAvailability(textField: UITextField, label: UILabel, result: Bool, message: String) {
        textField.layer.borderWidth = result ? 0.0 : 2.0
        textField.layer.borderColor = result ? nil : UIColor.systemRed.cgColor
        label.text = message
        label.textColor = result ? .systemGreen : .systemRed
    }
    
    @objc func passwordTextFieldBecomeFirstResponder() {
        passwordTextField.becomeFirstResponder()
    }
    
    @objc func confirmPasswordTextFieldBecomFirstResponder() {
        confirmPasswordTextField.becomeFirstResponder()
    }
    
    @objc func nameTextFieldBecomeFirstResponder() {
        nameTextField.becomeFirstResponder()
    }
    
    @objc func nameTextFieldResignFirstResponder() {
        nameTextField.resignFirstResponder()
    }
    
    @objc func applyRegularExpressionWithIdentifier(_ notification: Notification) {
        guard let userInfo = notification.userInfo?.values,
            let result = userInfo.first as? (fact: Bool, message: String) else { return }
        checkAvailability(
            textField: identifierTextField,
            label: idetnfierStatusLabel,
            result: result.fact,
            message: result.message
        )
        confirmStatus.idetnifier = result.fact
    }
    
    @objc func applyRegularExpressionWithPassword(_ notification: Notification) {
        guard let userInfo = notification.userInfo?.values,
            let result = userInfo.first as? (fact: Bool, message: String) else { return }
        checkAvailability(
            textField: passwordTextField,
            label: passwordStatusLabel,
            result: result.fact,
            message: result.message
        )
        confirmStatus.password = result.fact
    }
    
    @objc func postPassword() {
        guard let text = passwordTextField.text else { return }
        NotificationCenter
            .default
            .post(
                name: Notification.Name.pushPassword,
                object: nil,
                userInfo: ["password": text]
        )
    }
    
    @objc func comparePassword(_ notification: Notification) {
        guard let userInfo = notification.userInfo?.values,
            let result = userInfo.first as? (fact: Bool, message: String) else { return }
        checkAvailability(
            textField: confirmPasswordTextField,
            label: confirmPasswordStatusLabel,
            result: result.fact,
            message: result.message
        )
        confirmStatus.confirmPassword = result.fact
    }
    
    @objc func isEmptyNameTextField(_ notification: Notification) {
        guard let userInfo = notification.userInfo?.values,
            let result = userInfo.first as? (fact: Bool, message: String) else { return }
        checkAvailability(
            textField: nameTextField,
            label: nameStatusLabel,
            result: result.fact,
            message: result.message
        )
        confirmStatus.name = result.fact
    }
    
    @objc func isEnabledNextButton(_ notification: Notification) {
        guard let userInfo = notification.userInfo?.values,
            let result = userInfo.first as? Bool else { return }
        nextButton.tintColor = result ? .systemGreen : .systemGray
        nextButton.isEnabled = result
        nextButton.setTitleColor(result ? .systemGreen : .systemGray, for: .normal)
    }
}
