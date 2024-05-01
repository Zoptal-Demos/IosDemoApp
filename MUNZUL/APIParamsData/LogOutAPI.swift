//
//  LogOutAPI.swift
//  MUNZUL
//
//  Created by Sonoma on 31/03/24.
//

import Foundation

struct LogOUTAPIData: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .delete
    var relativeURL: String = UniformResourceLocator.LogOUT_Delete
    var headers: [String: String]? = [
        "accept": "application/json",
        "x-token": KeyChainService.shared.getSavedLoginToken() ?? "",
        "Content-Type": "application/json"
    ]

}

struct Log_out_Model: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
}
