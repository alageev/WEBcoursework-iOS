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
    @State var user = User.NewUser()
    @State var passwordsDoNotMatch = false
    @State private var selectedImage: UIImage? = nil
    
    init(show: Binding<Bool>, request: LoginRequest){
        self.request = request
        self._show = show
    }
    
    var body: some View {
        Form {
            Section(header: Text("Already_have_an_account?")) {
                Button(action: {show.toggle()}, label: {Text("Log_In_noun")})
            }
            Section(header: Text("Fill_this_fields")) {
                TextField("email", text: $user.email)
                    .textContentType(.username)
                    .keyboardType(.emailAddress)
                TextField("name", text: $user.name)
                    .textContentType(.givenName)
                TextField("lastname", text: $user.lastname)
                    .textContentType(.familyName)
                TextField("nickname", text: $user.nickname)
                    .textContentType(.nickname)
                SecureField("password", text: $user.password)
                    .textContentType(.newPassword)
                SecureField("confirm_password", text: $user.confirmPassword)
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
                                "Choose_photo":
                                "Change_photo", comment: ""),
                            description: NSLocalizedString("Photo_description", comment: ""))
            }
            
            Section {
                Button(action: {
                    passwordsDoNotMatch = false
                    if user.password == user.confirmPassword {
                        if selectedImage != nil {
                            imageLoader.uploadImage(selectedImage!)
                            user.imageLink = imageLoader.fileName
                        }
                        request.makeRequest(user: user, .registration)
                    } else {
                        passwordsDoNotMatch = true
                    }
                }, label: {
                    Text("Sign_In_verb")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                .disabled(disableForm)
            }
        }
        .navigationTitle("Sign_In_noun")
    }
}

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage(show: .constant(true), request: LoginRequest(isLoggedIn: .constant(false)))
    }
}
