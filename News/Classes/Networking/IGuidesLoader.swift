//
//  HTMLLoader.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 15.12.2020.
//

import Foundation
import SwiftSoup
import UIKit

class IGuidesLoader: ObservableObject {
    
    @Published var loadedData: [Post.iGuidesPost] = []
    
    private var links: [URL] = []
    private let iGuides = "https://www.iguides.ru"
    
    init(url: URL) {
        Constants.shared.session.dataTask(with: URLRequest(url: url)) { data, response, error in
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
                    Constants.shared.session.dataTask(with: URLRequest(url: link)) { data, response, error in
                        guard let data = data else {
                            fatalError("Invalid Data")
                        }
                        
                        let htmlDocument = String(decoding: data, as: UTF8.self)
                        do {
                            let doc: Document = try SwiftSoup.parse(htmlDocument)
                            let articleDetail = try doc.select("div.article-detail")
                            let postImageLink = try articleDetail.select("img[itemprop=image]").attr("src")
                            let postImageURL: URL
                            if postImageLink.hasPrefix("https://www.iguides.ru") {
                                postImageURL = URL(string: postImageLink)!
                            } else {
                                postImageURL = URL(string: self.iGuides + postImageLink)!
                            }
                            let authorContainer = try doc.select("div.author")
                            let authorImageLink = try authorContainer.select("img").attr("src")
                            let authorImageURL: URL
                            if authorImageLink.hasPrefix("https://www.iguides.ru") {
                                authorImageURL = URL(string: authorImageLink)!
                            } else {
                                authorImageURL = URL(string: self.iGuides + authorImageLink)!
                            }
                            let authorFullname = try doc.select("div.author").select("span[itemprop=name]").text()
                            let header = try doc.select("h1[itemprop=name]").text()
                            let postText = String(try articleDetail.text())
                            var postImage: UIImage = UIImage()
                            var authorImage: UIImage = UIImage()
                            Constants.shared.session.dataTask(with: URLRequest(url: postImageURL)) { data, _, error in
                                guard let data = data else {
                                    return
                                }
                                
                                postImage = UIImage(data: data)!
                                
                                Constants.shared.session.dataTask(with: URLRequest(url: authorImageURL)) { data, _, error in
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
                                        self.loadedData.append(post)
                                    }
                                }.resume()
                            }.resume()
                            
                        } catch Exception.Error(_, let message) {
                            print(message)
                        } catch {
                            print("error loading html")
                        }
                    }.resume()                }
                
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("error loading html")
            }
        }.resume()
    }
}
