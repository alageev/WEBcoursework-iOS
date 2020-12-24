//
//  IGuidesPostDetail.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 22.12.2020.
//

import SwiftUI

struct IGuidesPostDetail: View {
    let post: Post.iGuidesPost
    
    var body: some View {
        ScrollView {
            Image(uiImage: post.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(post.header)
                            .font(.largeTitle)
                        Text("\(post.authorFullName)")
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(uiImage: post.authorPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .clipped()
                }
                Divider()
                Text(post.text).multilineTextAlignment(.leading)
            }.padding()
        }
    }
}

struct IGuidesPostDetail_Previews: PreviewProvider {
    static var previews: some View {
//        iGuidesPostDetail()
        EmptyView()
    }
}
