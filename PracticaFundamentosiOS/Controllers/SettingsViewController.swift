//
//  SettingsViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 13/9/22.
//

import UIKit

class SettingsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onTapLogOut(_ sender: UIButton) {

        // Dismiss View without modal presemter like Xibs
        // If we used navigation controller push when logging in, we can use this to logout:
        // With animation <-
        LocalDataModel.deleteToken()
        navigationController?.viewControllers.insert(LoginViewController(), at: 0)
        
        navigationController?.popViewController(animated: true)
        // With animation ->
//        navigationController?.setViewControllers([ViewController()], animated: true)
        
        dismiss(animated: true)
    }
    
}
