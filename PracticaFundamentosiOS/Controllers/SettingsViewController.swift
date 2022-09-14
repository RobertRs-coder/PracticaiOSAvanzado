//
//  SettingsViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 14/9/22.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onLogOutPressed(_ sender: UIButton) {
    
        LocalDataModel.deleteToken()
        
        let loginViewController = LoginViewController ()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginViewController)
    }
}
