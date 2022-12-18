//
//  ImageManager.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 18/12/2022.
//

import Foundation
import UIKit

protocol ImageManagerProtocol: AnyObject {
    // MARK:
    // Required for caching image
    var cache: NSCache<NSString, UIImage>! { get set }
    
    func loadImage(for url: URL, completion: @escaping (Result<UIImage, ImageManagerError>) -> ()) 
}

final class ImageManager: ImageManagerProtocol {
    var cache: NSCache<NSString, UIImage>! = NSCache<NSString, UIImage>()
    
    func loadImage(for url: URL, completion: @escaping (Result<UIImage, ImageManagerError>) -> ()) {
        
        // Cached image for faster loading
        if let image = cachedImage(for: url) {
            completion(.success(image))
            return
        }
        
        downloadImage(url: url) { result in
            if let image = try? result.get() {
                self.saveImage(image, for: url)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func makeKey(_ url: URL) -> NSString {
        return url.absoluteString as NSString
    }
    
    private func cachedImage(for url: URL) -> UIImage? {
        return cache.object(forKey: makeKey(url))
    }
    
    private func saveImage(_ image: UIImage,for url: URL) {
        return cache.setObject(image, forKey: makeKey(url))
    }
    
    private func downloadImage(url: URL, completion: @escaping (Result<UIImage, ImageManagerError>) -> ()) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let networkError = error {
                completion(.failure(ImageManagerError.network(networkError)))
            }
            
            guard let imageData = data else {
                completion(.failure(ImageManagerError.noData))
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completion(.failure(ImageManagerError.badData))
                return
            }
            
            completion(.success(image))
        }
        task.resume()
    }
}
