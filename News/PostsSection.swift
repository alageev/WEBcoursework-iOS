//
//  PostsSection.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 24.12.2020.
//

import SwiftUI

struct PostsSection: View {
    
    @ObservedObject var posts = Post.loaded
    
    var body: some View {
        Section(header: Text("Посты пользователей")) {
            ForEach (posts.loadedData ?? [], id: \.id) { post in
                withAnimation {
                    PostRow(post: post)
                }
            }
        }
    }
}

struct PostsSection_Previews: PreviewProvider {
    static var previews: some View {
        PostsSection()
    }
}
