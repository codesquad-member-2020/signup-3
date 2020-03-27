//
//  NotificationCenter.swift
//  SignUp
//
//  Created by Cloud on 2020/03/26.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var identifier: Notification.Name = Notification.Name("identifier")
    static var password: Notification.Name = Notification.Name("password")
    static var confirmPassword: Notification.Name = Notification.Name("confirmPassword")
    static var name: Notification.Name = Notification.Name("name")
    static var regularExpressionWithIdentifier: Notification.Name = Notification.Name("regularExpressionWithIdentifier")
    static var regularExpressionWithPassword: Notification.Name = Notification.Name("regularExpressionWithPassword")
    static var fetchPassword: Notification.Name = Notification.Name("fetchPassword")
    static var pushPassword: Notification.Name = Notification.Name("pushPassword")
    static var comparePasswords: Notification.Name = Notification.Name("comparePasswords")
    static var isEmptyName: Notification.Name = Notification.Name("isEmptyName")
    static var postEnabledButton: Notification.Name = Notification.Name("postPassword")
    static var isEnabledButton: Notification.Name = Notification.Name("isEnabledButton")
}
