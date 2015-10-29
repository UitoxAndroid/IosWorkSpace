//
//  SignInDelegate.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/10/23.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 登入頁跳出之後的動作
protocol SignInDelegate 
{
	func signInSuccess()
	func signInCancel()
}