//
//  ProfileDetailsID.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 15/03/24.
//

import Foundation

struct ProfileDataAPI: APIData {

    let userID: String

       init(userID: String) {
           self.userID = userID
       }
       
       var parameterEncoding: ParameterEncoding = .url
       var requestMethod: RequestMethod = .get
       var relativeURL: String {
           return "/user/profile/\(userID)"
       }
       var headers: [String: String]? = [
           "accept": "application/json",
           "x-token": KeyChainService.shared.getSavedLoginToken() ?? "",
           "Host": "api.munzul.com" // Add the Host header here

       ]
   }
