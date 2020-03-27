//
//  IdentifierTextFieldDelegate.swift
//  SignUp
//
//  Created by Cloud on 2020/03/26.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class PasswordTextFieldDelegate: NSObject {
    weak var viewModel: SignUpViewModel?
}

extension PasswordTextFieldDelegate: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 2.0
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: Notification.Name.password, object: nil)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let result = viewModel?.applyPasswordRegularExpression(text).0 ?? false
        let success = viewModel?.applyPasswordRegularExpression(text).1 ?? ""
        let fail = viewModel?.applyPasswordRegularExpression(text).2 ?? ""
        NotificationCenter
            .default
            .post(
                name: Notification.Name.regularExpressionWithPassword,
                object: nil,
                userInfo: result ? ["result": (true, success)] : ["result": (false, fail)]
        )
    }
}
