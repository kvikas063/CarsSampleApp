//
//  LoadingIndicator.swift
//  Cars
//
//  Created by Vikas Kumar on 03/03/22.
//

import UIKit

extension UIView {
    
    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView.init(style: .white)

        if let _ = self.viewWithTag(200) as? UIActivityIndicatorView {
            
        } else {
            activityIndicator.center = self.center
            activityIndicator.color = UIColor.black
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = 200
            self.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.viewWithTag(200) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
