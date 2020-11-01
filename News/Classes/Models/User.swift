//
//  User.swift
//  News
//
//  Created by Алексей Агеев on 28.10.2020.
//

import Foundation

final class User {
    
    var id: UUID?
    var email: String
    var name: String
    var lastname: String
    var nickname: String
    var password: String
    var imageLink: String?
        
    init(id:        UUID?   = nil,
         email:     String,
         name:      String,
         lastname:  String,
         nickname:  String,
         password:  String,
         imageLink: String? = nil) {
        
        self.id = id
        self.email = email.lowercased()
        self.name = name
        self.lastname = lastname
        self.nickname = nickname
        self.password = password
        self.imageLink = imageLink
    }
}

extension User {
    struct NewUser: Codable {
        var email: String = ""
        var name: String = ""
        var lastname: String = ""
        var nickname: String = ""
        var password: String = ""
        var confirmPassword: String = ""
        var imageLink: String? = nil
    }
    
    struct OldUser: Codable {
        var email: String = ""
        var password: String = ""
    }
    
    struct ThisUser {
        var id: UUID? = nil
        var email: String = ""
        var name: String = ""
        var lastname: String = ""
        var nickname: String = ""
        var password: String = ""
        var imageLink: String? = nil
        var token: String = ""
    }
    
    struct JWT: Decodable {
        var token: String
    }
    
    struct AnotherUser {
        var id: UUID? = nil
        var name: String = ""
        var lastname: String = ""
        var nickname: String = ""
        var imageLink: String? = nil
    }
}
