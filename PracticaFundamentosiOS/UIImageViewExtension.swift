//
//  UIImageViewExtension.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import Foundation
import UIKit

typealias ImageCompletion = (UIImage?) -> Void
extension UIImageView {
    
    func setImage(url: URL) {
        // Main thread to change something in UI
        downloadImageWithUrlSession(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    private func downloadImageWithUrlSession(url: URL, completion: ImageCompletion?) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
            let image = UIImage(data: data) else {
                completion?(nil)
                return
            }
            completion?(image)
        }.resume()
    }
}
