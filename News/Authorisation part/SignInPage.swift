//
//  SignInPage.swift
//  News
//
//  Created by Алексей Агеев on 25.10.2020.
//

import SwiftUI

struct SignInPage: View {
    var disableForm: Bool {
        !user.email.isValidEmail ||
        user.name.count == 0 ||
        user.lastname.count == 0 ||
        user.nickname.count == 0 ||
        user.password.count == 0 ||
        user.confirmPassword.count == 0
    }
    var request: LoginRequest
    let imageLoader = ImageLoader()
    @State var showAction: Bool = false
    @Binding var show: Bool
    @State var user = User.Registration()
    @State var passwordsDoNotMatch = false
    @State private var selectedImage: UIImage? = nil
    
    init(show: Binding<Bool>, request: LoginRequest){
        self.request = request
        self._show = show
    }
    
    var body: some View {
        Form {
            Section(header: Text("Уже есть аккаунт?")) {
                Button(action: {show.toggle()}, label: {Text("Вход")})
            }
            Section(header: Text("Заполните эти поля")) {
                TextField("Email", text: $user.email)
                    .textContentType(.username)
                    .keyboardType(.emailAddress)
                TextField("Имя", text: $user.name)
                    .textContentType(.givenName)
                TextField("Фамилия", text: $user.lastname)
                    .textContentType(.familyName)
                TextField("Nickname", text: $user.nickname)
                    .textContentType(.nickname)
                SecureField("Пароль", text: $user.password)
                    .textContentType(.newPassword)
                SecureField("Повторите пароль", text: $user.confirmPassword)
                    .textContentType(.password)
            }
            
            Section {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .clipped()
                        .ignoresSafeArea()
                }
                PhotoButton(selectedImage: $selectedImage,
                            title: NSLocalizedString(selectedImage == nil ?
                                "Выбрать фото":
                                "Сменить фото", comment: ""),
                            description: "Это фото будет установлено фотографией вашего профиля")
            }
            
            Section {
                Button(action: {
                    passwordsDoNotMatch = false
                    if user.password == user.confirmPassword {
                        if selectedImage != nil {
                            imageLoader.image = selectedImage!
                        }
                        request.makeRequest(user: user, .registration, next: imageLoader.uploadImage)
                    } else {
                        passwordsDoNotMatch = true
                    }
                }, label: {
                    Text("Зарегистрироваться")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                .disabled(disableForm)
            }
        }
        .navigationTitle("Регистрация")
    }
    
    func register(){
        
    }
}

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage(show: .constant(true), request: LoginRequest(isLoggedIn: .constant(false)))
    }
}
