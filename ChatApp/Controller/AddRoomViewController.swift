//
//  AddRoomViewController.swift
//  ChatApp
//
//  Created by Yoookooooooo on 2021/01/18.
//

import UIKit
import Firebase

class AddRoomViewController: UIViewController {
    
    
    @IBOutlet weak var roomNameTextField: UITextField!
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func addButton(_ sender: Any) {
        
        if roomNameTextField.text != nil{
            db.collection("ルーム一覧").addDocument(data: ["roomName":roomNameTextField.text!,"date":Date().timeIntervalSince1970]) { (error) in
                print(error.debugDescription)
                return
            }
            dismiss(animated: true, completion: nil)
            let chatVC = storyboard?.instantiateViewController(withIdentifier: "VCVCVC")
            navigationController?.pushViewController(chatVC!, animated: true)
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
