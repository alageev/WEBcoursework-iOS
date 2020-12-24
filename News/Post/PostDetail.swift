//
//  PostDetail.swift
//  News
//
//  Created by Алексей Агеев on 01.11.2020.
//

import SwiftUI

struct PostDetail: View {
    
    @ObservedObject var postImageLoader: ImageLoader
    @ObservedObject var userImageLoader: ImageLoader
    let post: Post.Server
    
    init(post: Post.Server) {
        postImageLoader = ImageLoader()
        userImageLoader = ImageLoader()
        self.post = post
        
        postImageLoader.downloadImage(for: post.id)
        userImageLoader.downloadImage(for: post.author.id)
    }
    
    var body: some View {
        ScrollView {
            if let image = postImageLoader.image {
                Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
            }
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(post.header)
                            .font(.largeTitle)
                        Text("\(post.author.name) \(post.author.lastname)")
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    if let image = userImageLoader.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .clipped()
                    }
                }
                Divider()
                Text(post.text).multilineTextAlignment(.leading)
            }.padding()
        }
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail(post: testPosts[0])
            .previewDevice("iPhone 12 Pro Max")
        PostDetail(post: testPosts[0]).previewDevice("iPod touch (7th generation)")
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
