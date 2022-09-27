//
//  UIViewControllerExtension.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 17/9/22.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertACtion = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertACtion)
        self.present(alert, animated: true)
    }
}
