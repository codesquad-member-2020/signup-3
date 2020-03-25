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
}

extension SignUpDataManager: RegularExpression {
    func regex(_ text: String, kinds: String, completion: (Bool, String, String) -> Void) {
        switch kinds {
        case "identifier":
            completion(
                text.getArrayAfterRegex(regex: identifierRegularExpression).isEmpty,
                "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다.",
                "사용 가능한 아이디입니다."
            )
        default:
            completion(
                text.getArrayAfterRegex(regex: passwordRegularExpression).isEmpty,
                "사용할 수 없는 비밀번호입니다.",
                "사용 가능한 비밀번호입니다."
            )
        }
    }
}
