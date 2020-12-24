//
//  PostRow.swift
//  News
//
//  Created by Алексей Агеев on 22.10.2020.
//

import SwiftUI

struct PostRow: View {
    
    @ObservedObject var imageLoader: ImageLoader
    @State var isPresented = false
    let post: Post.Server
    
    init(post: Post.Server) {
        imageLoader = ImageLoader()
        self.post = post
        imageLoader.downloadImage(for: post.id)
    }
    
    var body: some View {
        Button(action: { isPresented.toggle() }, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(post.author.name) \(post.author.lastname)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(post.header)
                        .font(.title3)
                        .foregroundColor(.primary)
                }
                Spacer()
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .clipped()
                }
            }
        })
        .sheet(isPresented: $isPresented, content: {
            PostDetail(post: post)
        })
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: testPosts[0])
            .previewLayout(.sizeThatFits)
    }
}
