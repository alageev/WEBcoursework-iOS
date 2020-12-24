//
//  Post.swift
//  News
//
//  Created by Алексей Агеев on 22.10.2020.
//

import Foundation
import UIKit

struct Post {
    
    static let loaded = JSONLoader<[Post.Server]>(url: Constants.shared.feed)
    static let iGuides = IGuidesLoader(url: URL(string: "https://www.iguides.ru")!)
    
    struct Local: Encodable {
        var id: UUID = UUID()
        var header: String = ""
        var text: String = ""
    }

    struct iGuidesPost: Identifiable {
        let id = UUID()
        var header: String
        var text: String
        var authorFullName: String
        var image: UIImage
        var authorPhoto: UIImage
    }
    
    struct Server: Decodable {
        let id: String
        let header: String
        let text: String
        let author: User.Server
        
        init(id: String, header: String, text: String, name: String, lastname: String) {
            self.id = id
            self.header = header
            self.text = text
            self.author = User.Server(id: User.id,
                                      email: User.email,
                                      name: User.name,
                                      lastname: User.lastname,
                                      nickname: User.nickname)
        }
    }
}
