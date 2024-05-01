//
//  CompanyDetailUpdate.swift
//  MUNZUL
//
//  Created by Navdeep on 02/04/24.
//

import Foundation


struct CompanyDetailUpdateAPI: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .patch
    var relativeURL: String = UniformResourceLocator.CompanyDetailUpdate
    var headers: [String: String]? = [
        "accept": "application/json",
        "x-token": KeyChainService.shared.getSavedLoginToken() ?? "",
        "Content-Type": "application/json"
    ]

    var name: String
    var website: String
    var latitude: Double
    var longitude: Double
    var contact: String
//    var country_code: String
    var address: String
    var city: String
    var zipcode: String

    // Implement the `params()` method to return the parameters
    func params() -> [String: Any] {
        return [
            "name": name,
            "website": website,
            "longitude": longitude,
            "latitude": latitude,
            "contact": contact,
//            "country_code": country_code,
            "city": city,
            "zipcode": zipcode,
            "address": address
        ]
    }
}





