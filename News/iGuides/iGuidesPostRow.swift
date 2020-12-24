//
//  IGuidesPostRow.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 22.12.2020.
//

import SwiftUI

struct IGuidesPostRow: View {
    
    @State var isPresented = false
    let post: Post.iGuidesPost
    
    var body: some View {
        Button(action: { isPresented.toggle() }){
            HStack {
                VStack(alignment: .leading){
                    Text("\(post.authorFullName)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text(post.header)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                Spacer()
                Image(uiImage: post.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .clipped()
            }
        }
        //        .foregroundColor(.primary)
        .sheet(isPresented: $isPresented, content: {
            IGuidesPostDetail(post: post)
        })
    }
}

struct IGuidesPostRow_Previews: PreviewProvider {
    static var previews: some View {
//        iGuidesPostRow()
        EmptyView()
    }
}
