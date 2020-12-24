//
//  ContentView.swift
//  Shared
//
//  Created by Алексей Агеев on 21.10.2020.
//

import SwiftUI

struct ContentView: View {

    @State var isLoggedIn = false

    var body: some View {
        if !isLoggedIn {
            Authorization(isLoggedIn: $isLoggedIn)
        } else {
            TabsSelector()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
