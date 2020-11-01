//
//  JSONLoader.swift
//  Jungle
//
//  Created by Алексей Агеев on 13.09.2020.
//

import Foundation

class JSONLoader<T: Decodable>: ObservableObject {
    @Published var data: [T] = [T]()
    @Published var isLoaded = false

    init(url: URL) {
        var request = URLRequest(url: url)
        request.addValue(thisUser.token, forHTTPHeaderField: "Authorization")
        session.dataTask(with: request) { data, response, error in
            do {
                guard let data = data
                else {
                    fatalError("Invalid Data")
                }
                let decodedJSON = try JSONDecoder().decode([T].self, from: data)
                DispatchQueue.main.async {
                    self.data = decodedJSON
                    self.isLoaded = true
                }
            } catch {
                print("Error decoding JSON: ", error)
            }
        }.resume()
    }
}
