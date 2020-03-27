//
//  ViewController.swift
//  SignUp
//
//  Created by Cloud on 2020/03/25.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let manager = SignUpDataManager()
    private let identifierTextFieldDelegate = IdentifierTextFieldDelegate()
    private let passwordTextFieldDelegate = PasswordTextFieldDelegate()
    private let confirmTextFieldDelegate = ConfirmPasswordTextFieldDelegate()
    private let nameTextFieldDelegate = NameTextFieldDelegate()
    private var signupView: SignUpView {
        return view as! SignUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupView.identifierTextField.delegate = identifierTextFieldDelegate
        signupView.passwordTextField.delegate = passwordTextFieldDelegate
        signupView.confirmPasswordTextField.delegate = confirmTextFieldDelegate
        signupView.nameTextField.delegate = nameTextFieldDelegate
        identifierTextFieldDelegate.viewModel = manager
        passwordTextFieldDelegate.viewModel = manager
        confirmTextFieldDelegate.viewModel = manager
        nameTextFieldDelegate.viewModel = manager
    }
}

