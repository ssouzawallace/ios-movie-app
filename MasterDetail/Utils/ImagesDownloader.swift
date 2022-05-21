//
//  ImagesService.swift
//  MasterDetail
//
//  Created by user on 19/05/22.
//

import Foundation
import UIKit

enum FileSize: String {
    case thumbnail = "w200"
    case fullWidth = "original"
}

class ImagesDownloader {
    private let baseUrl = "https://image.tmdb.org/t/p/"
    private var cachedImages: NSCache<NSURL, UIImage> = NSCache()
    
    private func fullPath(for filePath: String, fileSize: FileSize = .fullWidth) -> String {
        return baseUrl + fileSize.rawValue + filePath
    }
    
    public final func image(for filePath: String, fileSize: FileSize = .fullWidth) -> UIImage? {
        guard let url = NSURL(string: fullPath(for: filePath, fileSize: fileSize)) else { return nil }
        return cachedImages.object(forKey: url)
    }
    
    func download(_ filePath: String, fileSize: FileSize = .fullWidth, completion: @escaping (UIImage?) -> Void) {
        guard let url = NSURL(string: fullPath(for: filePath, fileSize: fileSize)) else { return }
        
        if let image = image(for: filePath, fileSize: fileSize) { completion(image) }
        
        URLSession.shared.dataTask(with: url as URL) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.cachedImages.setObject(image, forKey: url, cost: data.count)
            completion(image)
        }.resume()
    }
}
