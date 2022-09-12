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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: IBActions
    @IBAction func loginOnTap(_ sender: UIButton) {
        let model = NetworkModel()
        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        guard !user.isEmpty, !password.isEmpty else { return }
        
        model.login(user: user, password: password) { token, _ in
            print("Your token is: \(token ?? "")")
            
            guard let token = token, !token.isEmpty else {
                return
            }
           
                let nextViewController = HeroesTableViewController()
                self.navigationController?.setViewControllers([nextViewController], animated: true)
            
        }
    }
}
