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
    
    init(post: Post.Server){
        imageLoader = ImageLoader()
        self.post = post
        imageLoader.downloadImage(from: post.id)
    }
    
    var body: some View {
        Button(action: {isPresented.toggle()}){
            HStack {
                VStack(alignment: .leading){
                    Text("\(post.author.name) \(post.author.lastname)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(post.header)
                        .font(.title3)
                        .foregroundColor(.primary)
                }
                Spacer()
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .clipped()
                }
            }
        }
//        .foregroundColor(.primary)
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
