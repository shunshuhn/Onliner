//
//  ViewController.swift
//  Onliner
//
//  Created by 伊藤　陽香 on 2020/10/12.
//  Copyright © 2020 伊藤　陽香. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    
   
    override func viewDidLoad() {//画面が生成された時に呼ばれる、初めて表示された時に呼ばれる
        super.viewDidLoad()
        
        nameTextField.placeholder = "Name"
    }
   //「名前」のところに、何も表示しない
    override func viewWillAppear(_ animated: Bool) {//画面が表示される直前に呼ばれる
        nameTextField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {//画面が表示された直後に呼ばれる
        super.viewDidAppear(animated)
        
        
        //ユーザーが保存されている時、タイムライン画面に移動する
        if let _ = UserDefaults.standard.object(forKey: "loginName") {
            performSegue(withIdentifier: "toTimeline", sender: nil)
        }
        
    }
    
    @IBAction func login() {
        
        //「名前」のところに、何かが入力されている時
        if nameTextField.text != "" {
            
            let userDefaults = UserDefaults.standard
            //ユーザーデフォルトに、ユーザーネームを保存
            userDefaults.set(nameTextField.text, forKey: "loginName")
            //タイムライン画面に移動する
            performSegue(withIdentifier: "toTimeline", sender: nil)
            
            
            
        }else {
           // print("名前を入力してください")
        }
        
    }


}

