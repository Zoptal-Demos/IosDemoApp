//
//  RegistrationAPIData.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 13/03/24.
//

import Foundation

struct RegistrationAPIData: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .post
    var relativeURL: String = UniformResourceLocator.RegisterURL
    var headers: [String: String]? = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]

    // Parameters specific to the registration API
    var name: String
    var email: String
    var password: String
    var address: String
    var latitude: Double
    var longitude: Double
    var about: String
    var role: String
    var deviceToken: String
    var deviceType: String
    var appVersion: String
    var deviceModel: String

    // Implement the `params()` method to return the parameters
    func params() -> [String: Any] {
        return [
            "name": name,
            "email": email,
            "password": password,
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
            "about": about,
            "role": role,
            "device_token": deviceToken,
            "device_type": deviceType,
            "app_version": appVersion,
            "device_model": deviceModel
        ]
    }
}
