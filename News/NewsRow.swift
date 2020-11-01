//
//  NewsRow.swift
//  News
//
//  Created by Алексей Агеев on 22.10.2020.
//

import SwiftUI

struct NewsRow: View {
    
    @ObservedObject var imageLoader: ImageLoader
    @State var isPresented = false
    let post: Post.PostWithAuthorData
    
    init(post: Post.PostWithAuthorData){
        imageLoader = ImageLoader()
        self.post = post
        if post.imageLink != nil {
            imageLoader.downloadImage(from: post.imageLink!)
        }
    }
    
    var body: some View {
        Button(action: {isPresented.toggle()}){
            HStack {
                VStack(alignment: .leading){
                    Text("\(post.author.name) \(post.author.lastname)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(post.header ?? "")
                        .font(.title)
                }
                Spacer()
                Image(uiImage: imageLoader.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .clipped()
            }
        }
        .foregroundColor(.primary)
        .sheet(isPresented: $isPresented, content: {
            NewsDetail(post: post)
        })
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(post: testPosts[0])
            .previewLayout(.sizeThatFits)
    }
}
