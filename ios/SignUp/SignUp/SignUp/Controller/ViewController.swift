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
    private var signupView: SignUpView {
        return view as! SignUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupView.datasoure = manager
    }
}

