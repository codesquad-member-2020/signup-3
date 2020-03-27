//
//  SignUpDataManager.swift
//  SignUp
//
//  Created by Cloud on 2020/03/25.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

class SignUpDataManager: NSObject {
    private let identifierRegularExpression: String = "^[A-Za-z0-9_-]{5,20}$"
    private let passwordRegularExpression: String = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,16}"
    
    override init() {
        super.init()
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(getPassword),
                name: Notification.Name.postEnabledButton,
                object: nil
        )
    }
    
    @objc func getPassword(_ notification: Notification) {
        guard let userInfo =  notification.userInfo?.first,
            let result = userInfo.value as? (Bool, Bool, Bool, Bool) else { return }
        let value = result.0 && result.1 && result.2 && result.3
        NotificationCenter
            .default
            .post(
                name: Notification.Name.isEnabledButton,
                object: nil,
                userInfo: ["enable": value]
        )
    }
}

extension SignUpDataManager: SignUpViewModel {
    func applyIdentifierRegularExpression(_ text: String) -> results {
        (
            !text.getArrayAfterRegex(regex: identifierRegularExpression).isEmpty,
            "사용 가능한 아이디입니다.",
            "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
        )
    }
    
    func applyPasswordRegularExpression(_ text: String) -> results {
        (
            !text.getArrayAfterRegex(regex: passwordRegularExpression).isEmpty,
            "사용 가능한 비밀번호입니다.",
            "사용할 수 없는 비밀번호입니다."
        )
    }
    
    func comfirmPassword(_ x: String, _ y: String) -> results {
        (
            x == y,
            "비밀번호가 일치합니다.",
            "비밀번호가 일치하지 않습니다."
        )
    }
    
    func isEmptyName(_ text: String) -> results {
        (
            !text.isEmpty,
            "",
            "이름은 필수 입력사항입니다."
        )
    }
}
