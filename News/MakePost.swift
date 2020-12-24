//
//  MakePost.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 29.11.2020.
//

import SwiftUI

struct MakePost: View {
    
    @State var selectedImage: UIImage? = nil
    @State var post = Post.Local()
    @State var showAction = false
    
    var body: some View {
        List {
            Section {
                Button(action: { showAction.toggle() }, label: {
                    Text("Отправить")
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                .actionSheet(isPresented: $showAction) {
                    ActionSheet(title: Text("Опубликовать пост?"),
                                message: Text("Вы ещё можете его отредактировать. После отправки редактирование невозможно"),
                                buttons: [
                                    .default(Text("Отправить"), action: {
                                        let _ = PostLoader(post: post, image: selectedImage)
                                        withAnimation {
                                            selectedImage = nil
                                            post = Post.Local()
                                        }
                                    }),
                                    .cancel(Text("Отредактировать"))
                                ])
                }
            }
            Section {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .clipped()
                        .ignoresSafeArea()
                }
                PhotoButton(selectedImage: $selectedImage,
                            title: selectedImage == nil ? "Выбрать фото" : "Сменить фото",
                            description: "Это фото будет установлено фотографиенй вашего поста")
            }
//            TextField("Sign_in_noun", text: $post.text)
            Section {
                ZStack(alignment: .leading) {
                    if post.header.isEmpty {
                        Text("Заголовок")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    TextEditor(text: $post.header)
                        .font(.title)
                }
                ZStack(alignment: .leading) {
                    if post.text.isEmpty {
                        Text("Текст поста")
                            .foregroundColor(.gray)
                    }
                    TextEditor(text: $post.text)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct MakePost_Previews: PreviewProvider {
    static var previews: some View {
        MakePost()
    }
}
