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
//    @State var postsLoader = JSONLoader<[Post.Server]>(url: Constants.shared.feed)

    var body: some View {
        TabView(selection: $selectedTab) {
            if !isLoggedIn {
                Authorization(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: selectedTab ==  1 ? "person" : "person.fill")
                        Text("Войти")
                    }
                    .tag(0)
            } else {
                Feed()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "newspaper" : "newspaper.fill")
                    Text("Лента")
                }
                .tag(0)
                MakePost()
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "newspaper" : "newspaper.fill")
                        Text("Создать пост")
                    }
                    .tag(1)
                ProfileView()
                    .tabItem {
                        Image(systemName: selectedTab ==  1 ? "person" : "person.fill")
                        Text("Профиль")
                    }
                    .tag(2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
