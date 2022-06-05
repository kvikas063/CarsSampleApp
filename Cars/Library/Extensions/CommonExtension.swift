//
//  CommonExtension.swift
//  Cars
//
//  Created by Vikas Kumar on 03/03/22.
//

import UIKit

extension UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UIImageView {
    
    func downloadImage(withUrl url: URL) {
        if let imageUrl = NSURL(string: url.absoluteString) {
            if let cachedImage = APPDELEGATE.imageCache.object(forKey: imageUrl) {
                //Return Cached Image
                self.animateImage(with: cachedImage)
            } else {
                //Download Image
                URLSession.shared.dataTask(with: url, completionHandler: {
                    (data, response, error) -> Void in
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            self.animateImage(with: image)
                            APPDELEGATE.imageCache.setObject(image, forKey: imageUrl)
                        }
                    }
                }).resume()
            }
        }
    }
    
    func animateImage(with image: UIImage) {
        UIView.transition(with: self, duration: 0.2, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
