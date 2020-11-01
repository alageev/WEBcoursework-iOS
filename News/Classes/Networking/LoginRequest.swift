//
//  LoginRequest.swift
//  News
//
//  Created by Алексей Агеев on 25.10.2020.
//

import Foundation
import SwiftUI

class LoginRequest: ObservableObject {
    
    enum requestDestination {
        case login
        case registration
    }
    
    @Published var isLoaded = false
    @Binding var isLoggedIn: Bool
    
//    var request: URLRequest
    
    init(isLoggedIn: Binding<Bool>) {
        self._isLoggedIn = isLoggedIn
    }
    
    func makeRequest<T: Encodable>(user: T, _ requestFor: requestDestination){
        
        var request: URLRequest
        switch requestFor {
        case .login:
            request = URLRequest(url: constants.login)
        case .registration:
            request = URLRequest(url: constants.registration)
        }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        isLoaded = false
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            print("can't encode json")
        }
        
        session.dataTask(with: request) {data, response, error in
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
                    print("decodedJSON: \(decodedJSON)")
                    if decodedJSON.token.count > 0 {
                        self.isLoaded = true
                        self.isLoggedIn = true
                        thisUser.token = decodedJSON.token
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
