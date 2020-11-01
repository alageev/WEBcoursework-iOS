//
//  NewsDetail.swift
//  News
//
//  Created by Алексей Агеев on 01.11.2020.
//

import SwiftUI

struct NewsDetail: View {
    
    @ObservedObject var postImageLoader: ImageLoader
    @ObservedObject var userImageLoader: ImageLoader
    let post: Post.PostWithAuthorData
    
    init(post: Post.PostWithAuthorData){
        postImageLoader = ImageLoader()
        userImageLoader = ImageLoader()
        self.post = post
        
        if post.imageLink != nil {
            postImageLoader.downloadImage(from: post.imageLink!)
        }
        if post.author.imageLink != nil {
            userImageLoader.downloadImage(from: post.author.imageLink!)
        }
    }
    
    
    var body: some View {
        ScrollView {
            if post.imageLink != nil {
                Image(uiImage: postImageLoader.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
            }
            VStack(alignment: .leading){
                HStack {
                    VStack(alignment: .leading) {
                        Text(post.header!)
                            .font(.largeTitle)
                        Text("\(post.author.name) \(post.author.lastname)")
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    if post.author.imageLink != nil {
                        Image(uiImage: userImageLoader.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .clipped()
                    }
                }
                Divider()
                Text(post.text)
            }.padding()
        }
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(post: testPosts[0])
            .previewDevice("iPhone 12 Pro Max")
        NewsDetail(post: testPosts[0]).previewDevice("iPod touch (7th generation)")
    }
}

//
//struct PostWithAuthorData: Identifiable {
//    let id: UUID?
//    let author: User.AnotherUser
//    let replyTo: UUID?
//    let header: String?
//    let text: String
//    let imageLink: String?
//    let numberOfLikes: UInt64
//    let numberOfDislikes: UInt64
//}

//var id: UUID? = nil
//var name: String = ""
//var lastname: String = ""
//var nickname: String = ""
//var imageLink: String? = nil
