//
//  TabBarController.swift
//  ChatApp
//
//  Created by Yoookooooooo on 2021/01/16.
//

import UIKit
import Firebase
import FirebaseAuth

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
        try firebaseAuth.signOut()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
       let testVC = storyboard?.instantiateViewController(withIdentifier: "testVC")
        navigationController?.pushViewController(testVC!, animated: true)
    }
    
    
}
