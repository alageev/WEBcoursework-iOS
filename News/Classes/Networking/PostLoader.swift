//
//  PostLoader.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 22.12.2020.
//

import Foundation
import Combine
import UIKit

class PostLoader: ObservableObject {
    
    init(post: Post.Local, image: UIImage?) {
        let parameters: [String: Any] = [
            "id":       post.id,
            "authorId": User.id,
            "header":   post.header,
            "text":     post.text
        ]
        print(parameters)
        var request = URLRequest(url: Constants.shared.feed)
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEncoded()
        session.dataTask(with: request) {  data, response, error in
            guard let image = image,
                  let response = response as? HTTPURLResponse,
                  error == nil,
                  (200 ... 299) ~= response.statusCode else {
                return
            }
            let imageLoader = ImageLoader()
            print("ImageLoader created")
            imageLoader.image = image
            print("ImageLoader image assigned")
            imageLoader.uploadImage(id: post.id)
            print("ImageLoader uploaded")
            
        }.resume()
    }
}

