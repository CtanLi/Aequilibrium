//
//  LaunchController.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-10.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import UIKit

class LaunchController: UIViewController {

    private let viewControllerSegue = "viewControllerSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       saveToken()
    }
    
    func saveToken() {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "token") == nil {
            let tokenString = BaseAPIClient.urlFromPath(path: APIEndPoints.getToken)
            APIService.shared.getTokenData(method: .get, urlString: tokenString, params: nil, headers: nil) { (result: TokenModel) in
                if !result.token.isEmpty {
                    defaults.set(result.token, forKey: "token")
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: self.viewControllerSegue, sender: self)
        })
    }
}
