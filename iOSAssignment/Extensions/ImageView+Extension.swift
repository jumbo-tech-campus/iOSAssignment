//
//  ImageView+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

import UIKit

private let storageImage = NSCache<NSString, UIImage>()

extension UIImageView {

    func addImage(path: String, placeholder: UIImage? = R.image.iconNoImage()) {
        guard
            let localImage = storageImage.object(forKey: path as NSString)
        else {
            let thread = DispatchQueue(label: #filePath, qos: .default, attributes: .concurrent)
            thread.async { [weak self] in
                DispatchQueue.main.async { self?.startLoader() }

                let downloadedImage = self?.downloadImage(from: path)
                DispatchQueue.main.async {
                    self?.image = downloadedImage ?? placeholder
                    self?.stopLoader()
                }
            }
            return
        }

        image = localImage
    }

    private func downloadImage(from urlString: String) -> UIImage? {
        guard
            let url = URL(string: urlString),
            let dataImage = try? Data(contentsOf: url),
            let image = UIImage(data: dataImage)
        else { return nil }

        storageImage.setObject(image, forKey: urlString as NSString)
        return image
    }
}
