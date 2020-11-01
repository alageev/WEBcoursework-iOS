//
//  LoginPage.swift
//  News
//
//  Created by Алексей Агеев on 25.10.2020.
//

import SwiftUI

struct LoginPage: View {

    var disableForm: Bool {
        !user.email.isValidEmail ||
        user.password.count == 0
    }
    
    var request: LoginRequest
    @Binding var show: Bool
    @State var user = User.OldUser()
        
    init(show: Binding<Bool>, request: LoginRequest){
        self.request = request
        self._show = show
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("Don't_have_an_account?")){
                Button(action: { show.toggle() }, label: { Text("Sign_In_noun") })
            }
            
            Section(header: Text("Fill_this_fields")) {
                TextField("email", text: $user.email)
                    .textContentType(.username)
                    .keyboardType(.emailAddress)
                SecureField("password", text: $user.password)
                    .textContentType(.password)
            }
                Button(action: {
                    request.makeRequest(user: user, .login)
                }, label: {
                    Text("Log_In_verb")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                .disabled(disableForm)
        }
        .ignoresSafeArea(.container)
        .navigationTitle("Log_In_noun")
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(show: .constant(true), request: LoginRequest(isLoggedIn: .constant(false)))
    }
}

