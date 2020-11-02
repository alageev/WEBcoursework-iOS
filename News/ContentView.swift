//
//  ContentView.swift
//  Shared
//
//  Created by Алексей Агеев on 21.10.2020.
//

import SwiftUI

struct ContentView: View {

    @State var isLoggedIn = false
    @State var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Feed(posts: testPosts)
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "newspaper" : "newspaper.fill")
                    Text("Feed")
                    
                }
                .tag(0)
            if !isLoggedIn {
                Authorization(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: selectedTab ==  1 ? "person" : "person.fill")
                        Text("Log_In_noun")
                        
                    }
                    .tag(1)
            } else {
                ProfileView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//import SwiftUI
//
//struct ContentView: View {
//
//    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
//    @State private var selectedImage: UIImage?
//    @State private var isImagePickerDisplay = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//
//                if selectedImage != nil {
//                    Image(uiImage: selectedImage!)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .clipShape(Circle())
//                        .frame(width: 300, height: 300)
//                } else {
//                    Image(systemName: "snow")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .clipShape(Circle())
//                        .frame(width: 300, height: 300)
//                }
//
//                Button("Camera") {
//                    self.sourceType = .camera
//                    self.isImagePickerDisplay.toggle()
//                }.padding()
//
//                Button("photo") {
//                    self.sourceType = .photoLibrary
//                    self.isImagePickerDisplay.toggle()
//                }.padding()
//            }
//            .navigationBarTitle("Demo")
//            .sheet(isPresented: self.$isImagePickerDisplay) {
//                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
//            }
//
//        }
//    }
//}
