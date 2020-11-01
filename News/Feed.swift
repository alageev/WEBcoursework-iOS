//
//  Feed.swift
//  News
//
//  Created by Алексей Агеев on 22.10.2020.
//

import SwiftUI

struct Feed: View {
    
    let posts: [Post.PostWithAuthorData]
    
    var body: some View {
        NavigationView {
            List (posts) { post in
                Section {
//                NavigationLink(destination:) {
                    NewsRow(post: post)
//                }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Feed")
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed(posts: testPosts)
    }
}
