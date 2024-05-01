//
//  SocialAPIData.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 15/03/24.
//

import Foundation

struct SocialLoginModelData: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .post
    var relativeURL: String = UniformResourceLocator.SocialLoginURL
    var headers: [String: String]? = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]

    // Parameters specific to the social login API
    var name: String
    var email: String
    var address: String
    var latitude: Double
    var longitude: Double
    var role: String
    var loginType: String
    var deviceToken: String
    var deviceType: String
    var appVersion: String
    var deviceModel: String
    var socialID: String

    // Implement the `params()` method to return the parameters
    func params() -> [String: Any] {
        return [
            "name": name,
            "email": email,
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
            "role": role,
            "login_type": loginType,
            "device_token": deviceToken,
            "device_type": deviceType,
            "app_version": appVersion,
            "device_model": deviceModel,
            "social_id": socialID
        ]
    }
}
