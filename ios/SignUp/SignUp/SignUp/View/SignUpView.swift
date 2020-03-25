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
    private let identifierTextFieldKey: String = "identifier"
    private let passwordTextFieldKey: String = "password"
    private let confirmPasswordTextFieldKey: String = "confirmPassword"
    private let nameTextFieldKey: String = "name"
    weak var datasoure: RegularExpression?
    
    // MARK: - Lifecycles
    
    // MARK: - IBActions
    @IBAction func gestureAction(_ sender: Any) {
        endEditing(true)
    }
    
    // MARK: - Methods
    private func highlightingWithBlue(_ textField: UITextField, boderWidth: CGFloat) {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = boderWidth
    }
    
    private func applyViewWithRegularExpression(textField: UITextField, label: UILabel, result: Bool, message: ( fail: String, sucess: String)) {
        textField.layer.borderWidth = result ? 2.0 : 0.0
        textField.layer.borderColor = result ? UIColor.systemRed.cgColor : nil
        label.text = result ? message.fail : message.sucess
        label.textColor = result ? .systemRed : .systemGreen
    }
    
    private func activateNextButton() {
        let result = idetnfierStatusLabel.textColor == .systemGreen
            && passwordStatusLabel.textColor == .systemGreen
            && confirmPasswordStatusLabel.textColor == .systemGreen
            && nameStatusLabel.text?.isEmpty ?? true
        nextButton.tintColor = result ? .systemGreen : .systemGray
        nextButton.isEnabled = result ? true : false
        nextButton.setTitleColor(result ? .systemGreen : .systemGray, for: .normal)
    }
}

extension SignUpView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        highlightingWithBlue(textField, boderWidth: 2.0)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.restorationIdentifier {
        case identifierTextFieldKey:
            passwordTextField.becomeFirstResponder()
        case passwordTextFieldKey:
            confirmPasswordTextField.becomeFirstResponder()
        case confirmPasswordTextFieldKey:
            nameTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField.restorationIdentifier {
        case identifierTextFieldKey:
            datasoure?.regex(text, kinds: "identifier") { result, fail, sucess  in
                applyViewWithRegularExpression(
                    textField: textField,
                    label: idetnfierStatusLabel,
                    result: result,
                    message: (fail,sucess)
                )
            }
        case passwordTextFieldKey:
            datasoure?.regex(text, kinds: "password") { result, fail, sucess in
                applyViewWithRegularExpression(
                    textField: textField,
                    label: passwordStatusLabel,
                    result: result,
                    message: (fail, sucess)
                )
            }
        case confirmPasswordTextFieldKey:
            let result = passwordTextField.text == textField.text && !(textField.text?.isEmpty ?? true)
            applyViewWithRegularExpression(
                textField: textField,
                label: confirmPasswordStatusLabel,
                result: !result,
                message: ("비밀번호가 일치하지 않습니다.","비밀번호가 일치합니다.")
            )
        default:
            applyViewWithRegularExpression(
                textField: textField,
                label: nameStatusLabel,
                result: textField.text?.isEmpty ?? true,
                message: ("이름은 필수 입력 항목입니다.","")
            )
        }
        activateNextButton()
    }
}
