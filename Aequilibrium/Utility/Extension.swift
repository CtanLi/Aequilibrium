//
//  Extension.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-11.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCacheWithURLString(urlString: String) {
        if urlString == "" {
            return
        }
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            DispatchQueue.main.async {
                if let downloadedImages = UIImage(data: data!) {
                    imageCache.setObject(downloadedImages, forKey: urlString as NSString)
                    self.image = downloadedImages
                }
            }
        }).resume()
    }
}

extension Array where Element: Equatable {
    @discardableResult mutating func remove(object: Element) -> Bool {
        if let index = firstIndex(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }
}

