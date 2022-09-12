//
//  LoginViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: IBOUtlets
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        
        // Do any additional setup after loading the view.
    }

    //MARK: IBActions
    @IBAction func loginOnTap(_ sender: UIButton) {
        let model = NetworkModel()
        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        guard !user.isEmpty, !password.isEmpty else { return }
        
        model.login(user: user, password: password) { [weak self] token, _ in
            print("Your token is: \(token ?? "")")
            
            guard let token = token, !token.isEmpty else {
                return
            }
            
            DispatchQueue.main.async {
                let nextViewController = HeroesTableViewController()
                self?.navigationController?.setViewControllers([nextViewController], animated: true)
            }
        }
    }
}
