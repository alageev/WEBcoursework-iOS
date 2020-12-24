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
    
    let cloudinary: CLDCloudinary
    
    @Published var image: UIImage?
    
    init () {
        let config = CLDConfiguration(cloudinaryUrl: Constants.shared.cloudinaryURL)!
        self.cloudinary = CLDCloudinary(configuration: config)
    }

    func downloadImage(for id: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            let transformation = CLDTransformation().setWidth(642)
            guard let imageUrl = self.cloudinary.createUrl().setTransformation(transformation).generate(id) else {
                return
            }
            self.cloudinary.createDownloader().fetchImage(imageUrl, completionHandler: { image, error in
                guard error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                }
            })
        }
    }
    
    func uploadImage(id: UUID) {
        DispatchQueue.global(qos: .userInteractive).async {
            let params = CLDUploadRequestParams().setPublicId(id.uuidString)
            guard let imageData = self.image?.jpegData(compressionQuality: 1) else {
                print("can't make JPG")
                return
            }
            self.cloudinary.createUploader().upload(data: imageData, uploadPreset: "news_upload", params: params)
                .response { _, error in
                    guard error == nil else {
                        return
                    }
                }
        }
    }
    
    func uploadImage(with post: Post.Server) {
        
        let params = CLDUploadRequestParams().setPublicId(post.id)
        guard let imageData = self.image?.jpegData(compressionQuality: 1) else {
            print("can't make JPG")
            return
        }
        
        self.cloudinary.createUploader()
            .upload(data: imageData, uploadPreset: "news_upload", params: params,
                    completionHandler: { _, error in
                        guard error == nil else {
                            print(error!)
                            return
                        }
                        Post.loaded.loadedData?.append(post)
                    })
    }
    
}
