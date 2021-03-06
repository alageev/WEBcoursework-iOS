//
//  JSONLoader.swift
//  Jungle
//
//  Created by Алексей Агеев on 13.09.2020.
//

import Foundation
import UIKit

class JSONLoader<T: Decodable>: ObservableObject {
    @Published var loadedData: T?
    @Published var isLoaded = false
    @Published var imageLoader = ImageLoader()

    init(url: URL) {
        var request = URLRequest(url: url)
        request.addValue("Bearer \(User.token)", forHTTPHeaderField: "Authorization")
        Constants.shared.session.dataTask(with: request) { data, _, error in
            do {
                guard let data = data
                else {
                    fatalError("Invalid Data")
                }
                let decodedJSON = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
//                    if T.self == User.Server.self {
//                        let user = decodedJSON as! User.Server
//                        self.imageLoader.downloadImage(for: user.id)
//                    }
                    self.loadedData = decodedJSON
                    self.isLoaded = true
                }
            } catch {
                print("Error decoding JSON: ", error)
            }
        }.resume()
    }
}
