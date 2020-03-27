//
//  RegularExpression.swift
//  SignUp
//
//  Created by Cloud on 2020/03/25.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

protocol SignUpViewModel: NSObject {
    func applyIdentifierRegularExpression(_ text: String) -> results
    func applyPasswordRegularExpression(_ text: String) -> results
    func comfirmPassword(_ x: String, _ y: String) -> results
    func isEmptyName(_ text: String) -> results
}



