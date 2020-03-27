//
//  IdentifierTextFieldDelegate.swift
//  SignUp
//
//  Created by Cloud on 2020/03/26.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class ConfirmPasswordTextFieldDelegate: NSObject {
    
    weak var viewModel: SignUpViewModel?
    var comparedText: String?
    
    override init() {
        super.init()
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(compare),
                name: Notification.Name.pushPassword,
                object: nil
        )
    }
    
    @objc func compare(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: String] else { return }
        comparedText = userInfo.first?.value
    }
}

extension ConfirmPasswordTextFieldDelegate: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 2.0
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NotificationCenter
            .default
            .post(
                name: Notification.Name.confirmPassword,
                object: nil
        )
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        NotificationCenter
            .default
            .post(
                name: Notification.Name.fetchPassword,
                object: nil
        )
        guard let text = textField.text,
            let comparedText = comparedText else { return }
        let result = viewModel?.comfirmPassword(text, comparedText).0 ?? false
        let success = viewModel?.comfirmPassword(text, comparedText).1 ?? "실패"
        let fail = viewModel?.comfirmPassword(text, comparedText).2 ?? "실패"
        NotificationCenter
            .default
            .post(
                name: Notification.Name.comparePasswords,
                object: nil,
                userInfo: result ? ["result": (true, success)] : ["result": (false, fail)]
        )
    }
}
