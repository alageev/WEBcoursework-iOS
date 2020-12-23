//
//  Feed.swift
//  News
//
//  Created by Алексей Агеев on 22.10.2020.
//

import SwiftUI

struct Feed: View {
    
    @ObservedObject var posts = Post.loaded
    @ObservedObject var iGuidesPosts = Post.iGuides
    
    var body: some View {
        NavigationView {
            if let posts = posts {
                List {
                    Section(header: Text("Мои посты")) {
                        ForEach (posts.loadedData ?? [], id: \.id) { post in
                            PostRow(post: post)
                        }
                    }
                    Section(header: Text("Посты из iGuides.ru")) {
                        ForEach (iGuidesPosts.loadedData ?? []) { post in
                            iGuidesPostRow(post: post)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Лента")
            }
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
