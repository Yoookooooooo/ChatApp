//
//  SendToDBModel.swift
//  ChatApp
//
//  Created by Yoookooooooo on 2021/01/16.
//

import Foundation
import  FirebaseStorage
protocol SendProfileOKDelegate {
    func sendProfileOKDelegate(url:String)
}

class SendToDBModel{
    
    var sendProfileOKDelegate:SendProfileOKDelegate?
    
    init(){
        
    }
    
    func sendProfileImageData(data:Data){
        
        let image = UIImage(data: data)
        let profileImageData = image?.jpegData(compressionQuality: 0.1)
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpeg")
        
        imageRef.putData(profileImageData!, metadata: nil) { (metaData, error) in
            if error != nil{
                print("error")
                return
            }
            imageRef.downloadURL { (url, error) in
                if error != nil{
                    print("error")
                    return
                }
                print("bbbbbb")
                print(url!)
                
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
                self.sendProfileOKDelegate?.sendProfileOKDelegate(url: url!.absoluteString)
            }
        }
    }
    
}
