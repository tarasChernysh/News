//
//  NewsImageView.swift
//  News
//
//  Created by Taras Chernysh on 10/13/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit

let cashe = NSCache<NSString, UIImage>()

class NewsImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImage(withPath path: String) {
        guard let url = URL(string: path) else { return }
        imageUrlString = path
        image = nil
        if let imageFromCache = cashe.object(forKey: path as NSString) {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
                if self.imageUrlString == path {
                    self.image = imageToCache
                }
                cashe.setObject(imageToCache!, forKey: path as NSString)
            }
            }.resume()
    }
}
