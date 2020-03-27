//
//  IdentifierTextFieldDelegate.swift
//  SignUp
//
//  Created by Cloud on 2020/03/26.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class IdentifierTextFieldDelegate: NSObject {
    weak var viewModel: SignUpViewModel?
}

extension IdentifierTextFieldDelegate: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 2.0
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: Notification.Name.identifier, object: nil)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let result = viewModel?.applyIdentifierRegularExpression(text).0 ?? false
        let success = viewModel?.applyIdentifierRegularExpression(text).1 ?? ""
        let fail = viewModel?.applyIdentifierRegularExpression(text).2 ?? ""
        NotificationCenter
            .default
            .post(
                name: Notification.Name.regularExpressionWithIdentifier,
                object: nil,
                userInfo: result ? ["result": (true, success)] : ["result": (false, fail)]
        )
    }
}


