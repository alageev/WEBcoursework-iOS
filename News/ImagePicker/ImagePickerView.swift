//
//  ImagePickerView.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 01.11.2020.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

//struct ImagePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePickerView(selectedImage: <#T##Binding<UIImage?>#>, sourceType: <#T##UIImagePickerController.SourceType#>)
//    }
//}
