//
//  LoginError.swift
//  Login
//
//  Created by 김민석 on 1/17/24.
//

import Foundation

public enum LoginError: Error {
    case appleIdTokenError
    case kakaoTalkLoginError
    case kakaoAccountLoginError
    case naverLoginError
    case decodeError
    case transLoginTypeError
}
