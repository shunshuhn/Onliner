//
//  PostMessageViewController.swift
//  Onliner
//
//  Created by 伊藤　陽香 on 2020/10/14.
//  Copyright © 2020 伊藤　陽香. All rights reserved.
//

import UIKit
import Firebase

class PostMessageViewController: UIViewController {
    
    @IBOutlet var messageTextView: UITextView!
    var message = ""
    var name = ""
    var postTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func post() {
        message = messageTextView.text!
        name = UserDefaults.standard.object(forKey: "loginName") as! String
        
        let date = Date()
        let dateFmt = DateFormatter()
        
        dateFmt.dateFormat = "yyyy/mm/dd"
        postTime = (dateFmt.string(from: date))
        
        let dataBase = Firestore.firestore()
        //firebaseデータベースに保存する
        dataBase.collection("users").document().setData([
                    "userName": name,
                    "message": message,
                    "postTime":postTime,
                    "lastUpdated": FieldValue.serverTimestamp()
                ]) { error in
                if error != nil {
                        // エラー処理
                        print("エラー")
                        return
                    }
                    // 成功したときの処理
                    self.dismiss(animated: true, completion: nil)
                }

        
    }

}
