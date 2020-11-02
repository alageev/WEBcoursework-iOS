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
//                ForEach {
                    Section {
    //                NavigationLink(destination:) {
                        NewsRow(post: post)
    //                }
                    }
//                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Feed")
            
//            Button(<#T##title: StringProtocol##StringProtocol#>, action: <#T##() -> Void#>)
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed(posts: testPosts)
    }
}
