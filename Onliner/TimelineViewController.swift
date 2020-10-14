//
//  TimelineViewController.swift
//  Onliner
//
//  Created by 伊藤　陽香 on 2020/10/13.
//  Copyright © 2020 伊藤　陽香. All rights reserved.
//

import UIKit
import Firebase

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet var timelineTableView: UITableView!
    //Post class の配列
    var postArray = [Post]()
    let dataBase = Firestore.firestore()


    override func viewDidLoad() {
    super.viewDidLoad()
        
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        
        let xib = UINib(nibName: "TimelineViewCell", bundle: nil)
        timelineTableView.register(xib, forCellReuseIdentifier: "Cell")
    }

    //ログインでidを記入しなかったら匿名と表示される
//    if nameTextField.isEmpty {
//        nameTextField = "匿名"
//    }
//    idLabel.text = "ID: \(id)"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        dataBase.collection("users").order(by: "lastUpdated", descending: true).getDocuments { (snapshot, error) in
                if error == nil, let snapshot = snapshot {
                    self.postArray = []
                    for document in snapshot.documents {
                        let data = document.data()
                        let post = Post(data: data)
                        self.postArray.append(post)
                    }
                    self.timelineTableView.reloadData()
                }
            }
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //テーブルビューの配置
    //セルの数をpostArrayの数にする
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         as! TimelineViewCell
        //identifierを元に、セルを呼び出し
        
        //セルに、表示する
        cell.nameLabel?.text = postArray[indexPath.row].userName
        cell.messageLabel?.text = postArray[indexPath.row].message
        cell.dateLabel?.text = postArray[indexPath.row].postTime
        
        return cell
        
    }
    
    //ログアウトボタン
    @IBAction func logout() {
        UserDefaults.standard.removeObject(forKey: "loginName")
        self.dismiss(animated: true, completion: nil)
    }
    

    
    }
        

