//
//  LoginViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit
import KeychainSwift

final class LoginViewController: UIViewController {
    
    //MARK: IBOUtlets
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Constants
    let viewModel = LoginViewModel()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        activityIndicator.isHidden = true
        
        viewModel.onError = { [weak self] message in
            DispatchQueue.main.sync {
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.showAlert(title: "Error", message: "Problem server connection")
            }
        }
        
        viewModel.onLogin = { [weak self] in
            DispatchQueue.main.async {
                let tabBarController = CustomTabBarController()
                    // This is to get the SceneDelegate object from your view controller
                    // then call the change root view controller function to change to custom tab bar
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
                //Animations of button and activity indicator
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true

                let nextViewController = HeroesTableViewController()
                self?.navigationController?.setViewControllers([nextViewController], animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if KeychainSwift().get("KCToken") == nil {
            userTextField.center.x -= view.bounds.width
            passwordTextField.center.x -=  view.bounds.width
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                self.userTextField.center.x += self.view.bounds.width
            }, completion: nil)
            UIView.animate(withDuration: 0.75,
                           delay: 0.4,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                self.passwordTextField.center.x += self.view.bounds.width
            }, completion: nil)
            UIView.animate(withDuration: 1) {
                self.loginButton.alpha = 1
            }
        }
    }

    //MARK: IBActions
    @IBAction func loginOnTap(_ sender: UIButton) {

        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //Animations of button
        loginButton.isEnabled = false
        
        
        guard !user.isEmpty, !password.isEmpty else {
            self.showAlert(title: "Missing fields", message: "Please complete the fields")
            //Enabled button to other try
            loginButton.isEnabled = true
            return
        }
        //Animations of activity indicator
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        viewModel.login(with: user, password: password)
    }
}


