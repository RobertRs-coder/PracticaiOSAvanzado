//
//  SettingsViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 14/9/22.
//

import UIKit
import KeychainSwift

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onLogOutPressed(_ sender: UIButton) {
    
//        LocalDataModel.deleteToken()
        
        KeychainSwift().delete("KCToken")
        CoreDataManager().deleteAll()
        
        let loginViewController = LoginViewController ()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginViewController)
    }
}

