//
//  PhotoButton.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 01.11.2020.
//

import SwiftUI

struct PhotoButton: View {
    
    @Binding var selectedImage: UIImage?
    
    @State private var showAction: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isImagePickerDisplay = false

    let title: String
    let description: String
    
    var body: some View {
        Button(action: {
            showAction = true
        }, label: {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
        })
        .actionSheet(isPresented: $showAction) {
            ActionSheet(title: Text(title),
                        message: Text(description),
                        buttons: [
                            .default(Text("Выбрать из библиотеки"), action: {
                                sourceType = .photoLibrary
                                isImagePickerDisplay = true
                            }),
                            .default(Text("Сделать снимок"), action: {
                                sourceType = .camera
                                isImagePickerDisplay = true
                            }),
                            .cancel(Text("Продолжить без фото"))
                        ])
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    }
}
//
//struct PhotoButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoButton()
//    }
//}
