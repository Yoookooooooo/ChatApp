//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Yoookooooooo on 2021/01/18.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextLabel: UITextField!

    @IBOutlet weak var passwordTextLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        let email = emailTextLabel.text!
        let password = passwordTextLabel.text!
        
        if emailTextLabel.text == "admin@gmail.com"{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                if let user = result?.user {
                    self.performSegue(withIdentifier: "Admin", sender: nil)
                    
                }
            }
        }else{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                if let user = result?.user {
                    self.performSegue(withIdentifier: "Login", sender: nil)
                    
                }
            }
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
