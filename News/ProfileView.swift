//
//  ProfileView.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 02.11.2020.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var imageLoader = ImageLoader()
//    @ObservedObject var userData = User.loaded
    @ObservedObject var postsData = Post.loaded
    
    init() {
        imageLoader.downloadImage(from: User.id)
    }
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        if let image = imageLoader.image {
                            Image(uiImage: image)
                                .resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fit)
                        }
                        VStack(alignment: .leading) {
                            Text(User.name)
                            Text(User.lastname)
                            Text(User.email)
                            Text(User.nickname)
//                            Text(userData.loadedData?.name     ?? "")
//                            Text(userData.loadedData?.lastname ?? "")
//                            Text(userData.loadedData?.email    ?? "")
//                            Text(userData.loadedData?.nickname ?? "")
                        }
                    }
                }
                if let posts = postsData.loadedData {
                    Section {
                        let userPosts = posts.filter {
                            $0.author.id.lowercased() == User.id.lowercased()
                        }
                        ForEach (userPosts, id: \.id) { post in
                            PostRow(post: post)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
//        }
    }
}

struct AuthorizedView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
