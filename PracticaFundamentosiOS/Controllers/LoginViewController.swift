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
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if LocalDataModel.getToken() != nil {
//            goToNextViewContoller()
//       }
//    }

    //MARK: IBActions
    @IBAction func loginOnTap(_ sender: UIButton) {
        let network = NetworkModel()
        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //Animations of button
        loginButton.isEnabled = false
        
        
        guard !user.isEmpty, !password.isEmpty else {
            let alert = UIAlertController(title: "Missing fields", message: "Please complete the fields", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(alertAction)
            self.present(alert, animated: true)
            loginButton.isEnabled = true
            return
        }
        //Animations of activity indicator
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        network.login(user: user, password: password) { [weak self] token, error in
            
            guard let token = token, !token.isEmpty else {
                DispatchQueue.main.async{
                    //Animations of button and activity indicator
                    self?.loginButton.isEnabled = true
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    return
                }
                let alert = UIAlertController(title: "Error", message: "Problem server connection", preferredStyle: .alert)
                let alertACtion = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(alertACtion)
                self?.present(alert, animated: true)
                return
            }
            
            LocalDataModel.saveToken(token: token)
            
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
}
