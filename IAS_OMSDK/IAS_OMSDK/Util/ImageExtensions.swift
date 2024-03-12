//
//  ImageExtensions.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 02/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()
/**
 - This is a extension for loading a image using cache
 - Extension having a loadImageUsingCache function
 */
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String, onSuceess: @escaping () -> Void, onError: @escaping () -> Void) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            onSuceess()
            return
        }

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                DispatchQueue.main.async {
                    onError()
                }
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    onSuceess()
                }
            }

        }).resume()
    }
}

