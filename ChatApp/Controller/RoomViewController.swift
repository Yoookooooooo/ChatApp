//
//  RoomViewController.swift
//  ChatApp
//
//  Created by Yoookooooooo on 2021/01/18.
//

import UIKit
import ViewAnimator
import Firebase

class RoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var db = Firestore.firestore()
    
    var testArray:[String] = []
    
  //  var roomNameArray = ["誰でも話そうよ！","20代たまり場！","1人ぼっち集合","地球住み集合！！","好きなYoutuberを語ろう","大学生集合！！","高校生集合！！","中学生集合！！","暇なひと集合！","A型の人！！"]
 //   var roomImageStringArray = ["0","1","2","3","4","5","6","7","8","9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.isHidden = false
        loadRoom()
        let animation = [AnimationType.vector(CGVector(dx: 0, dy: 30))]
        
        UIView.animate(views: tableView.visibleCells, animations: animation, completion:nil)
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath)
        
        let imageview = cell.contentView.viewWithTag(1) as! UIImageView
        let label = cell.contentView.viewWithTag(2) as! UILabel
        
    //    imageview.image = UIImage(named: roomImageStringArray[indexPath.row])
        label.text = testArray[indexPath.row]
        cell.imageView?.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "roomChat", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let roomChatVC = segue.destination as! ChatViewController2
        roomChatVC.roomName = testArray[sender as! Int]
    }
    
    func loadRoom(){
        db.collection("ルーム一覧").order(by: "date").addSnapshotListener { (snapShot, error) in
            self.testArray = []
            if error != nil{
                print(error.debugDescription)
                return
            }
            if let snapShotDoc = snapShot?.documents{
                for doc in snapShotDoc{
                    let data = doc.data()
                    if let test = data["roomName"] as? String{
                        self.testArray.append(test)
                        
                    }
                    self.tableView.reloadData()
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
