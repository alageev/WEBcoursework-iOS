//
//  MainScreen.swift
//  News
//
//  Created by Алексей Агеев on 25.10.2020.
//

import SwiftUI

struct MainScreen: View {
    
    @State var selectedItem = 0
    
    var body: some View {
//        TabView(selection: $selectedItem) {
//            LoginPage()
//                .tag(0)
//            Feed()
//                .tag(1)
//        }
        EmptyView()
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
