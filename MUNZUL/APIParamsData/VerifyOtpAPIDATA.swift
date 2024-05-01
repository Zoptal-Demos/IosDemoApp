//
//  VerifyOtpAPIDATA.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 15/03/24.
//

import Foundation

struct VerifyOTPAPI: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .post
    var relativeURL: String = UniformResourceLocator.VerifyOTPURL
    var headers: [String: String]? = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    var email: String
    var otp: String

    func params() -> [String: Any] {
        return [
            "email": email,
            "otp": otp
        ]
    }
}

