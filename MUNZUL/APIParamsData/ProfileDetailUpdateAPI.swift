//
//  ProfileDetailUpdateAPI.swift
//  MUNZUL
//
//  Created by Navdeep on 01/04/24.
//

import Foundation


struct ProfileUpdateDetail: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .patch
    var relativeURL: String = UniformResourceLocator.ProfileDetailUpdate
    var headers: [String: String]? = [
        "accept": "application/json",
        "x-token": KeyChainService.shared.getSavedLoginToken() ?? "",
        "Content-Type": "application/json"
    ]

    // Parameters specific to the login API
    var name: String
    var about: String
    var latitude: Double
    var longitude: Double
    var email: String
    var contact: String
    var country_code: String
    var role: String
    var address: String

    // Implement the `params()` method to return the parameters
    func params() -> [String: Any] {
        return [
            "name": name,
            "about": about,
            "email": email,
            "longitude": longitude,
            "latitude": latitude,
            "contact": contact,
            "country_code": country_code,
            "role": role,
            "address": address
        ]
    }
}





