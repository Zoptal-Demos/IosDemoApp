//
//  UpdateFrame.swift
//  MUNZUL
//
//  Created by Sonoma on 26/03/24.
//

import Foundation

struct UpdateFrameAPIData: APIData {
    var parameterEncoding: ParameterEncoding = .json
    var requestMethod: RequestMethod = .patch
    var relativeURL: String = UniformResourceLocator.updateFrame
    var headers: [String: String]? = [
        "accept": "application/json",
        "x-token": KeyChainService.shared.getSavedLoginToken() ?? "",
        "Content-Type": "application/json"
    ]
    
    let frame: Int
  
    func params() -> [String: Any] {
        return [
            "frame": frame
        ]
    }
}
