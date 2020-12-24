//
//  TabsSelector.swift
//  News (iOS)
//
//  Created by Алексей Агеев on 25.12.2020.
//

import SwiftUI

struct TabsSelector: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Feed()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "newspaper" : "newspaper.fill")
                    Text("Лента")
                }
                .tag(0)
            MakePost()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "plus.circle" : "plus.circle.fill")
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

struct TabsSelector_Previews: PreviewProvider {
    static var previews: some View {
        TabsSelector()
    }
}
