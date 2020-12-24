//
//  LoginRequest.swift
//  News
//
//  Created by Алексей Агеев on 25.10.2020.
//

import Foundation
import SwiftUI

class LoginRequest: ObservableObject {
    
    enum RequestDestination {
        case login
        case registration
    }
    
    @Published var isLoaded = false
    @Binding var isLoggedIn: Bool
    
    init(isLoggedIn: Binding<Bool>) {
        self._isLoggedIn = isLoggedIn
    }
    
    func makeRequest<T: Encodable>(user: T, _ requestFor: RequestDestination,
                                   next: ((UUID) -> Void)? = nil) {
        
        var request: URLRequest
        switch requestFor {
        case .login:
            request = URLRequest(url: Constants.shared.login)
        case .registration:
            request = URLRequest(url: Constants.shared.registration)
        }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        isLoaded = false
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            print("can't encode json")
        }
        
        Constants.shared.session.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil
            else {// check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }
            do {
                let decodedJSON = try JSONDecoder().decode(User.JWT.self, from: data)
                DispatchQueue.main.async {
                    if decodedJSON.token.count > 0 {
                        
                        User.id = decodedJSON.id
                        User.email = decodedJSON.email
                        User.name = decodedJSON.name
                        User.lastname = decodedJSON.lastname
                        User.nickname = decodedJSON.nickname
                        User.token = decodedJSON.token
                        
                        self.isLoaded = true
                        self.isLoggedIn = true
                        
                        if next != nil {
                            let newUser = user as! User.Registration
                            next!(newUser.id)
                        }
                    }
                }
            } catch {
                print("error", error)
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
        }.resume()
    }
}
