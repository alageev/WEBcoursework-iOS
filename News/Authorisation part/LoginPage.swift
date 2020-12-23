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
    @State var user = User.Login()
        
    init(show: Binding<Bool>, request: LoginRequest){
        self.request = request
        self._show = show
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("Нет аккаунта?")){
                Button(action: { show.toggle() }, label: { Text("Регистрация") })
            }
            
            Section(header: Text("Заполните эти поля")) {
                TextField("Email", text: $user.email)
                    .textContentType(.username)
                    .keyboardType(.emailAddress)
                SecureField("Пароль", text: $user.password)
                    .textContentType(.password)
            }
            
            Section {
                Button(action: {
                    request.makeRequest(user: user, .login)
                }, label: {
                    Text("Войти")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                .disabled(disableForm)
            }
        }
        .ignoresSafeArea(.container)
        .navigationTitle("Вход")
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(show: .constant(true), request: LoginRequest(isLoggedIn: .constant(false)))
    }
}

