//
//  TimelineViewController.swift
//  Onliner
//
//  Created by 伊藤　陽香 on 2020/10/13.
//  Copyright © 2020 伊藤　陽香. All rights reserved.
//

import UIKit
import Firebase
//データソースメソッドの追加とデリゲートメソッドの追加
class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet var timelineTableView: UITableView!
    //Post class の配列
    var postArray = [Post]()
    let dataBase = Firestore.firestore()


    override func viewDidLoad() {
    super.viewDidLoad()
        
        
        timelineTableView.delegate = self
        timelineTableView.dataSource = self//タイムラインテーブルビューのデリゲートメソッドとデータソースメソッドはTimelineViewControllerメソッドに書くよ
        
        //TimelineViewCell.xibファイルを呼び出す！
        let xib = UINib(nibName: "TimelineViewCell", bundle: nil)
        //テーブルビューにセルidentifierを登録
        timelineTableView.register(xib, forCellReuseIdentifier: "Cell")
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //ドキュメントの取得
        dataBase.collection("users").order(by: "lastUpdated", descending: true).getDocuments { (snapshot, error) in
                if error == nil, let snapshot = snapshot {
                    self.postArray = []
                    for document in snapshot.documents {
                        let data = document.data()
                        let post = Post(data: data)
                        self.postArray.append(post)
                    }
                    //データの更新
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
    //セルの高さの調整
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    //セルの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         as! TimelineViewCell
        //identifierを元に、セルを呼び出し
        
        //セルに、表示する
        cell.nameLabel?.text = postArray[indexPath.row].userName//ポストアレイに保存されているデータから、usernameを呼び出している
        cell.messageLabel?.text = postArray[indexPath.row].message
        cell.categoryLabel?.text = postArray[indexPath.row].category
        cell.dateLabel?.text = postArray[indexPath.row].postTime

        
        return cell
        
    }
    
    //ログアウトボタン
    @IBAction func logout() {
        UserDefaults.standard.removeObject(forKey: "loginName")
        self.dismiss(animated: true, completion: nil)
    }
    

    
    }
        

