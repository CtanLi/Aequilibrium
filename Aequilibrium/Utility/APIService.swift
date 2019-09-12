//
//  APIService.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-10.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import Alamofire

class APIService {
    static let shared = APIService()
    func fetchGenericData<T: Decodable>(method: HTTPMethod, urlString: String, params: [String : Any]?, headers: [String : String]?, completion: @escaping (T?, Int?) -> ()) {
        var httpHeaders = HTTPHeaders()
        guard let url = URL(string: urlString) else { return }
        if let header = headers {
            httpHeaders = header
        }
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: httpHeaders).responseJSON { (responseObject) in
            if responseObject.result.isSuccess {
                guard let data = responseObject.result.value else { return }
                do {
                    let dataValue = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions()) as Data 
                    let object = try JSONDecoder().decode(T.self, from: dataValue)
                    DispatchQueue.main.async {
                        completion(object, nil)
                    }
                } catch let jsonErr {
                    print("Failed to serialize json:", jsonErr)
                }
            } else if responseObject.result.isFailure {
                let error = responseObject.result.error! as NSError
                 completion(nil, responseObject.response?.statusCode)
                print("Request failed with error: \(error.description)")
            }
        }
    }
    
    func getTokenData<T: Decodable>(method: HTTPMethod, urlString: String, params: [String : Any]?, headers: [String : String]?, completion: @escaping (T) -> ()) {
        var httpHeaders = HTTPHeaders()
        guard let url = URL(string: urlString) else { return }
        if let header = headers {
            httpHeaders = header
        }
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: httpHeaders).responseString { (responseObject) in
            if responseObject.result.isSuccess {
                guard let token = responseObject.result.value else { return }
                do {
                    let jsonObject = ["token": token]
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as Data
                    let object = try JSONDecoder().decode(T.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(object)
                    }
                } catch let jsonErr {
                    print("Failed to serialize json:", jsonErr)
                }
            }
        }
    }
}

