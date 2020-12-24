//
//  Constants.swift
//  News
//
//  Created by Алексей Агеев on 22.10.2020.
//

import Foundation

class Constants {
    
    static let shared = Constants()
    
    let user: URL
    let userSelf: URL
    let feed: URL
    let login: URL
    let registration: URL
    let cloudinaryURL: String
    let session = URLSession(configuration: .default)
    
    init() {
        guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
            fatalError("Couldn't find file 'Keys.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let string = plist?.object(forKey: "Server_URL") as? String else {
            fatalError("Couldn't find key 'Server_URL' in 'Keys.plist'.")
        }
        guard let url = plist?.object(forKey: "CLOUDINARY_URL") as? String else {
            fatalError("Couldn't find key 'CLOUDINARY_URL' in 'Keys.plist'.")
        }
        
        self.cloudinaryURL = url
        let serverAdress = URL(string: string)!
        feed = serverAdress.appendingPathComponent("post")
        user = serverAdress.appendingPathComponent("user")
        userSelf = user.appendingPathComponent("self")
        login = user.appendingPathComponent("login")
        registration = user.appendingPathComponent("registration")
        
    }
    
    func userById(_ id: UUID) -> URL {
        user.appendingPathComponent(id.uuidString)
    }
}

extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format: "SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
}

extension Dictionary {
    
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
    
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
