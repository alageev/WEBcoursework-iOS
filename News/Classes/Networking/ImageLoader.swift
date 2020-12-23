//
//  ImageLoader.swift
//  News
//
//  Created by Алексей Агеев on 01.11.2020.
//

import Foundation
import Cloudinary
import UIKit

final class ImageLoader: ObservableObject {
    
    let downloader: CLDDownloader
    let uploader: CLDUploader
    let cloudinary: CLDCloudinary
    
    @Published var image: UIImage? = nil
    
    init () {
        let config = CLDConfiguration(cloudinaryUrl: Constants.shared.cloudinaryURL)!
        self.cloudinary = CLDCloudinary(configuration: config)
        self.downloader = cloudinary.createDownloader()
        self.uploader = cloudinary.createUploader()
    }

    func downloadImage(from url: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            let imageUrl = self.cloudinary.createUrl().generate(url)!
            self.downloader.fetchImage(imageUrl + ".png", completionHandler: { image, error in
                guard error == nil else {
                    print("Error loading image: \(error!)")
                    
                    print("Error for:", imageUrl)
                    return
                }
                print("loaded from:", imageUrl)
                DispatchQueue.main.async {
                    self.image = image
                }
            })
        }
    }
    
    func uploadImage(id: UUID) {
        DispatchQueue.global(qos: .default).async {
            let params = CLDUploadRequestParams().setPublicId(id.uuidString.lowercased())
            guard let imageData = self.image?.pngData() else {
                print("can't make PNG")
                return
            }
            self.cloudinary.createUploader().upload(data: imageData, uploadPreset: "news_upload", params: params)
        }
    }
}
