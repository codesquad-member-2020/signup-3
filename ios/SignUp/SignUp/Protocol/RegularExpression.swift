//
//  RegularExpression.swift
//  SignUp
//
//  Created by Cloud on 2020/03/25.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

protocol RegularExpression: NSObject {
    func regex(_ text: String, kinds: String, completion: (Bool, String, String) -> Void)
}
