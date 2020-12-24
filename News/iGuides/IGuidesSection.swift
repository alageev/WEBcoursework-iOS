//
//  IGuidesSection.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 24.12.2020.
//

import SwiftUI

struct IGuidesSection: View {
    
    @ObservedObject var posts = Post.iGuides
    
    var body: some View {
        Section(header: Text("Посты из iGuides.ru")) {
            ForEach (posts.loadedData) { post in
                withAnimation {
                    IGuidesPostRow(post: post)
                }
            }
        }
    }
}

struct IGuidesSection_Previews: PreviewProvider {
    static var previews: some View {
        IGuidesSection()
    }
}
