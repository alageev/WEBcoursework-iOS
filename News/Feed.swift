//
//  Feed.swift
//  News
//
//  Created by Алексей Агеев on 22.10.2020.
//

import SwiftUI

struct Feed: View {
    
    var body: some View {
        NavigationView {
            List {
                PostsSection()
                IGuidesSection()
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Лента")
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
