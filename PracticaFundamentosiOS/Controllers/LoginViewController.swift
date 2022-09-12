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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        
        activityIndicator.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    //MARK: IBActions
    @IBAction func loginOnTap(_ sender: UIButton) {
        let model = NetworkModel()
        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        loginButton.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        
        
        guard !user.isEmpty, !password.isEmpty else { return }
        
        model.login(user: user, password: password) { [weak self] token, _ in
            print("Your token is: \(token ?? "")")
            
            guard let token = token, !token.isEmpty else {
                DispatchQueue.main.async {
                    self?.loginButton.isEnabled = true
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                let nextViewController = HeroesTableViewController()
                self?.navigationController?.setViewControllers([nextViewController], animated: true)
            }
        }
    }
}
