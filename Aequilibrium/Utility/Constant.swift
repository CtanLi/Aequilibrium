//
//  Constant.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-10.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import Foundation

class BaseAPIClient {
    class func urlFromPath(path: String) -> String {
        let endPointURL = "https://transformers-api.firebaseapp.com"
        let requestUrl = String(format: "%@%@", endPointURL, path)
        return  requestUrl
    }
}

struct APIEndPoints {
    
    static let authorizationHeader = ["Content-Type": "application/json", "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"]

    //getToken
    static let getToken = "/allspark"
    
    //createTransformers
    static let transformers = "/transformers"
}
