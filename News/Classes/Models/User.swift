//
//  User.swift
//  News
//
//  Created by Алексей Агеев on 28.10.2020.
//

import Foundation

struct User: Codable {
    static let loaded = JSONLoader<User.Server>(url: Constants.shared.userSelf)
    
    static var id: String = ""
    static var email: String = ""
    static var name: String = ""
    static var lastname: String = ""
    static var nickname: String = ""
    static var token: String = ""
    
    init () {
        User.id = ""
        User.email = ""
        User.name = ""
        User.lastname = ""
        User.nickname = ""
        User.token = ""
    }
    
    init (from user: User.Server){
        User.id = user.id
        User.email = user.email
        User.name = user.name
        User.lastname = user.lastname
        User.nickname = user.nickname
    }
    
    struct Registration: Codable {
        var id: UUID = UUID()
        var email: String = ""
        var name: String = ""
        var lastname: String = ""
        var nickname: String = ""
        var password: String = ""
        var confirmPassword: String = ""
    }
    
    struct Server: Codable {
        var id: String = ""
        var email: String = ""
        var name: String = ""
        var lastname: String = ""
        var nickname: String = ""
        var password: String = ""
    }
    
    struct Login: Codable {
        var email: String = ""
        var password: String = ""
    }
    
    struct JWT: Decodable {
        var token: String = ""
        var id: String = ""
        var email: String = ""
        var name: String = ""
        var lastname: String = ""
        var nickname: String = ""
    }
    
//    struct ThisUser {
//        var id: String = ""
//        var email: String = ""
//        var name: String = ""
//        var lastname: String = ""
//        var nickname: String = ""
//        var token: String = ""
//    }
}
