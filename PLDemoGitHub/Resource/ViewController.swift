//
//  ViewController.swift
//  PLDemoGitHub
//
//  Created by 連振甫 on 2021/9/18.
//

import UIKit

class ViewController: UIViewController {

    var user = User()
    var userData = [User.List]()
    var mineData:User.Detail?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        
    }
    
    func fetchData() {
        user.sendRequest(addPath: "?per_page=\(20)&since=\(userData.count)",method: .get, reponse: [User.List].self, completion: setupUsersData(result:))
        user.sendRequest(addPath:"/zinfu1111",method: .get, reponse: User.Detail.self, completion: setupUserData(result:))
    }
    
    func setupUsersData(result: Result<[User.List],Error>) {
        
        switch result {
        case .success(let data):
            self.userData = data
            print("\(#function) success \(self.userData)")
        case .failure(let error):
            print("\(#function) failure \(error.localizedDescription)")
        }
    }
    
    func setupUserData(result: Result<User.Detail,Error>) {
        
        switch result {
        case .success(let data):
            self.mineData = data
            print("\(#function) success \(self.mineData)")
        case .failure(let error):
            print("\(#function) failure \(error.localizedDescription)")
        }
    }
    
}

