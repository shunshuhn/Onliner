//
//  Post.swift
//  Onliner
//
//  Created by 伊藤　陽香 on 2020/10/13.
//  Copyright © 2020 伊藤　陽香. All rights reserved.
//

import Foundation
import Firebase

class Post{
    
    let userName: String
    let message: String
    let category: String
    let postTime: String
    let lastUpdate: Timestamp
    

    init(data: [String:Any]) {
        userName = data["userName"] as! String
        message = data["message"] as! String
        category = data["category"] as! String
        postTime = data["postTime"]as! String
        lastUpdate = data["lastUpdated"]as! Timestamp
    }
}
