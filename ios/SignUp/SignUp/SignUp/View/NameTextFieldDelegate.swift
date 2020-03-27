//
//  IdentifierTextFieldDelegate.swift
//  SignUp
//
//  Created by Cloud on 2020/03/26.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class NameTextFieldDelegate: NSObject {
    weak var viewModel: SignUpViewModel?
}

extension NameTextFieldDelegate: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 2.0
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: Notification.Name.name, object: nil)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let result = viewModel?.isEmptyName(text).0 ?? false
        let success = viewModel?.isEmptyName(text).1 ?? "실패"
        let fail = viewModel?.isEmptyName(text).2 ?? "실패"
        NotificationCenter
            .default
            .post(
                name: Notification.Name.isEmptyName,
                object: nil,
                userInfo: result ? ["result": (true, success)] : ["result": (false, fail)]
        )
    }
}
