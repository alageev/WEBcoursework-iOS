//
//  HTMLLoader.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 15.12.2020.
//

import Foundation
import SwiftSoup
import UIKit

class iGuidesLoader: ObservableObject {
    
    @Published var loadedData: [Post.iGuidesPost]? = nil
    
    private var links: [URL] = []
    private let iGuides = "https://www.iguides.ru"
    
    init(url: URL) {
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data else {
                fatalError("Invalid Data")
            }
            
            let htmlDocument = String(decoding: data, as: UTF8.self)
            do {
                let doc: Document = try SwiftSoup.parse(htmlDocument)
                let postsContainer = try doc.select("div.newsTape").select("div.info")
                let links = try postsContainer.select("a[href]")
                    .map { try $0.attr("href") }
                    .map { self.iGuides + $0 }
                    .map { URL(string: $0)! }
                
                for link in links {
                    session.dataTask(with: URLRequest(url: link)) { data, response, error in
                        guard let data = data else {
                            fatalError("Invalid Data")
                        }
                        
                        let htmlDocument = String(decoding: data, as: UTF8.self)
                        do {
                            let doc: Document = try SwiftSoup.parse(htmlDocument)
                            let articleDetail = try doc.select("div.article-detail")
                            let postImageURL = try URL(string: self.iGuides + articleDetail.select("img[itemprop=image]").attr("src"))!
                            let authorContainer = try doc.select("div.author")
                            let authorImageURL =
                                try URL(string: self.iGuides + authorContainer.select("img").attr("src"))!
                            
                            let authorFullname = try doc.select("div.author").select("span[itemprop=name]").text()
                            let header = try doc.select("h1[itemprop=name]").text()
                            let postText = String(try articleDetail.text())
                            var postImage: UIImage = UIImage()
                            var authorImage: UIImage = UIImage()
                            
                            session.dataTask(with: URLRequest(url: postImageURL)) { data, response, error in
                                
                                guard let data = data else {
                                    return
                                }
                                
                                postImage = UIImage(data: data)!
                                
                                session.dataTask(with: URLRequest(url: authorImageURL)) { data, response, error in
                                    guard let data = data else {
                                        return
                                    }
                                    DispatchQueue.main.async {
                                        authorImage = UIImage(data: data)!
                                        let post = Post.iGuidesPost(header: header,
                                                                    text: postText,
                                                                    authorFullName: authorFullname,
                                                                    image: postImage,
                                                                    authorPhoto: authorImage)
                                        if self.loadedData == nil {
                                            self.loadedData = []
                                        }
                                        self.loadedData?.append(post)
                                    }
                                }.resume()
                            }.resume()
                            
                        } catch Exception.Error(_, let message) {
                            print(message)
                        } catch {
                            print("error loading html")
                        }
                    }.resume()
                }
                
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("error loading html")
            }
        }.resume()
        
        
    }
}
