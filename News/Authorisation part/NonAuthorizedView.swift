//
//  NonAuthorizedView.swift
//  News
//
//  Created by Алексей Агеев on 29.10.2020.
//

import SwiftUI

struct NonAuthorizedView: View {
    
    @Binding var isLoggedIn: Bool
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Feed(posts: testPosts)
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "newspaper" : "newspaper.fill")
                    Text("Feed")
                    
                }
                .tag(0)
            Authorization(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "person" : "person.fill")
                    Text("Log_In_noun")
                    
                }
                .tag(1)
            
        }
    }
}

struct NonAuthorizedView_Previews: PreviewProvider {
    static var previews: some View {
        NonAuthorizedView(isLoggedIn: .constant(false))
    }
}
