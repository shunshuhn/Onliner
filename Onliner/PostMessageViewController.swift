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
    @IBOutlet var categorychoiceField: UITextField!
    var message = ""
    var category = ""
    var name = ""
    var postTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       categorychoiceField.placeholder = "タイトル"
    }
    
    @IBAction func post() {
        message = messageTextView.text!
        category = categorychoiceField.text!
        //ユーザーデフォルトという名前のインスタンスの倉庫から、ユーザーネームを取り出し
        name = UserDefaults.standard.object(forKey: "loginName") as! String
       
        
        
        //現在日時をdateに代入
        let date = Date()
        //デートフォーマッターのインスタンスを作成
        let dateFmt = DateFormatter()
        
        //日付の書式の設定
        dateFmt.dateFormat = "yyyy/MM/dd HH:mm"
        //日時文字列からDate型の日付を生成する
        postTime = (dateFmt.string(from: date))
        //print(dateFmt.string(from: date))
        
        //firebaseインスタンスの作成、初期化かな
        let dataBase = Firestore.firestore()
        
        //書き込まれたデータをfirebaseデータベースに書き込み
        //ドキュメントの作成
        //ドキュメントをusersコレクションに保存していく
        //key:value
        dataBase.collection("users").document().setData([
                    "userName": name,
                    "message": message,
                    "category": category,
                    "postTime": postTime,
                    "lastUpdated": FieldValue.serverTimestamp()
                ]) { error in
                if error != nil {
                        print("エラー")
                        return
                    }
        // 成功したとき
                    self.dismiss(animated: true, completion: nil)
                }
        
      
        
        

    }


}
