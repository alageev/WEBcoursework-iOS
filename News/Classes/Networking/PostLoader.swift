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
    
    @discardableResult
    init(post: Post.Local, image: UIImage?) {
        let parameters: [String: Any] = [
            "id": post.id,
            "authorId": User.id,
            "header": post.header,
            "text": post.text
        ]
        var request = URLRequest(url: Constants.shared.feed)
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEncoded()
        Constants.shared.session.dataTask(with: request) {  _, response, error in
            guard let image = image,
                  let response = response as? HTTPURLResponse,
                  error == nil,
                  (200 ... 299) ~= response.statusCode else {
                return
            }
            print("i'm sending post")
            let imageLoader = ImageLoader()
            imageLoader.image = image
            let post = Post.Server(id: post.id.uuidString,
                                   header: post.header,
                                   text: post.text,
                                   name: User.name,
                                   lastname: User.lastname)
            imageLoader.uploadImage(with: post)
        }.resume()
    }
}
