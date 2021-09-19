//
//  User.swift
//  PLDemoGitHub
//
//  Created by 連振甫 on 2021/9/18.
//

import Foundation

var userManager = User()

struct User {
    
    struct List:Codable {
        let login:String
        let id:Int
        let avatar_url:URL
        let type:String
    }
    
    struct Detail:Codable {
        let login:String
        let avatar_url:URL
        let id:Int
        let name:String?
        let location:String?
        let blog:URL?
        let followers:Int
        let following:Int
        let email:String?
    }
}

extension User:APIService{
    var route: APIRoute {
        get {
            .users
        }
        set {
            newValue
        }
    }
}
