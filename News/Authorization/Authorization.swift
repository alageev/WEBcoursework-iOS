//
//  Authorization.swift
//  News
//
//  Created by Алексей Агеев on 28.10.2020.
//

import SwiftUI

struct Authorization: View {
    
    @ObservedObject var request: LoginRequest
    @State var haveAnAccount = true
    
    init(isLoggedIn: Binding<Bool>) {
        self.request = LoginRequest(isLoggedIn: isLoggedIn)
    }
    
    var body: some View {
        NavigationView {
            if haveAnAccount {
                LoginPage(show: $haveAnAccount, request: request)
            } else {
                SignInPage(show: $haveAnAccount, request: request)
            }
        }
    }
}

struct Authorization_Previews: PreviewProvider {
    static var previews: some View {
        Authorization(isLoggedIn: .constant(false))
    }
}
