//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Yoookooooooo on 2021/01/16.
//

import UIKit
import Firebase
import SDWebImage

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBOutlet weak var messageTextField: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var roomName = String()
    var imageString = String()
    
    var messages:[Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "messageCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        messageTextField.frame = CGRect(x: view.frame.size.width * 0.05, y: view.frame.size.height - (tabBarController?.tabBar.frame.size.height)! - 50, width: view.frame.size.width * 0.75, height: 30)
        sendButton.frame = CGRect(x: view.frame.size.width * 0.8, y: 0, width: 60, height: 60)
        sendButton.center.y = messageTextField.center.y
        
        if UserDefaults.standard.object(forKey: "userImage") != nil{
            imageString = UserDefaults.standard.object(forKey: "userImage") as! String
        }
        
        if roomName == ""{
            roomName = (Auth.auth().currentUser?.email)!
            //roomName = "All"
            print("aaaaaaaaaaaaaaaaa")
            print(roomName)
        }
        
        navigationItem.title = roomName
        
        loadMessage(roomName: roomName)
        
    }
    
    func loadMessage(roomName:String){
        db.collection(roomName).order(by: "date").addSnapshotListener { (snapShot, error) in
            self.messages = []
            if error != nil{
                print(error.debugDescription)
                return
            }
            if let snapShotDoc = snapShot?.documents{
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    if let sender = data["sender"] as? String,let body = data["body"]as? String,let imageString = data["imageString"]as? String{
                        
                        let newMessage = Message(sender: sender, body: body, imageString: imageString)
                        self.messages.append(newMessage)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! messageCell
        
        let message = messages[indexPath.row]
        cell.label?.text = message.body
        cell.selectionStyle = .none
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.rightImageView.sd_setImage(with: URL(string: imageString), completed: nil)
   //         cell.leftImageView.sd_setImage(with:URL(string: messages[indexPath.row].imageString) , completed: nil)
            cell.backView.backgroundColor = .systemTeal
            cell.label.textColor = .white
        }else{
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
    //        cell.rightImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            cell.leftImageView.sd_setImage(with: URL(string: messages[indexPath.row].imageString), completed: nil)
            cell.backView.backgroundColor = .orange
            cell.label.textColor = .white

        }
        
        return cell
    }
    
    
    @IBAction func send(_ sender: Any) {
        
        if let messageBody = messageTextField.text,let sender = Auth.auth().currentUser?.email{
            db.collection(roomName).addDocument(data: ["sender":sender,"body":messageBody,"imageString":imageString,"date":Date().timeIntervalSince1970]) { (error) in
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    self.messageTextField.text = ""
                    self.resignFirstResponder()
                    print("aaaaaaaaaaaaaa")
                    print(self.imageString)
                }
                
                
                
            }
            if roomName == Auth.auth().currentUser?.email && db.collection(roomName) == nil{
                db.collection("ヘルプ一覧").addDocument(data: ["roomName":roomName,"date":Date().timeIntervalSince1970]) { (error) in
                    print(error.debugDescription)
                    return
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
