//
//  LogInData.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 15/03/24.
//

import Foundation

struct LoginModelData: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .post
    var relativeURL: String = UniformResourceLocator.LoginURL
    var headers: [String: String]? = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]

    // Parameters specific to the login API
    var email: String
    var password: String
    var latitude: Double
    var longitude: Double
    var loginType: String
    var deviceToken: String
    var deviceType: String
    var appVersion: String
    var deviceModel: String

    // Implement the `params()` method to return the parameters
    func params() -> [String: Any] {
        return [
            "email": email,
            "password": password,
            "latitude": latitude,
            "longitude": longitude,
            "login_type": loginType,
            "device_token": deviceToken,
            "device_type": deviceType,
            "app_version": appVersion,
            "device_model": deviceModel
        ]
    }
}
