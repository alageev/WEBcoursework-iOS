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
    static let iGuides = iGuidesLoader(url: URL(string: "https://www.iguides.ru")!)
    
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
        
        init(header: String, text: String, authorFullname: String) {
            self.id = UUID().uuidString
            self.header = header
            self.text = text
            let authorName = authorFullname.split(separator: " ").map { String($0) }
            self.author = User.Server(name: authorName[0], lastname: authorName[1])
        }
    }
}
