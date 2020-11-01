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
//    let config: CLDConfiguration
//    let cloudinary: CLDCloudinary
    let downloader: CLDDownloader
    let uploader: CLDUploader
    let cloudinary: CLDCloudinary
    let fileName = UUID().uuidString
    
    @Published var image: UIImage = UIImage(imageLiteralResourceName: "Placeholder")
    
    init () {
        let config = CLDConfiguration(cloudinaryUrl: constants.cloudinaryURL)!
        self.cloudinary = CLDCloudinary(configuration: config)
        self.downloader = cloudinary.createDownloader()
        self.uploader = cloudinary.createUploader()
    }
    
    func downloadImage(from url: String){
        DispatchQueue.global(qos: .userInteractive).async {
            let imageUrl = self.cloudinary.createUrl().generate(url)!
            self.downloader.fetchImage(imageUrl, completionHandler:  { (image, error) in
                DispatchQueue.main.async {
                    self.image = image ?? UIImage(imageLiteralResourceName: "Placeholder")
                }
            })
        }
        
    }
    
    func uploadImage(_ image: UIImage){
        DispatchQueue.global(qos: .userInteractive).async {
            let params = CLDUploadRequestParams().setFolder("news").setPublicId(self.fileName)
//            params
//            params
            guard let imageData = image.jpegData(compressionQuality: 1) else {
                print("can't make JPEG")
                return
            }
            self.uploader.upload(data: imageData, uploadPreset: "news_upload", params: params)
        }
    }
}
