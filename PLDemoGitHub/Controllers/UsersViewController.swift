//
//  UsersViewController.swift
//  PLDemoGitHub
//
//  Created by 連振甫 on 2021/9/20.
//

import UIKit

class UsersViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }
    }
    
    var userData = [User.List]()
    var selectedUser:User.Detail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
    }
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> UserDetailViewController? {
        guard let selectedUser = selectedUser
        else {
            print("debug123")
            return nil
            
        }
        return UserDetailViewController(coder: coder, userData: selectedUser)
    }
    
}
extension UsersViewController {
    
    func fetchData() {
        let since = userData.last?.id ?? 0
        userManager.sendRequest(addPath: "?per_page=\(20)&since=\(since)",method: .get, reponse: [User.List].self, completion: setupUsersData(result:))
    }
    
    func setupUsersData(result: Result<[User.List],Error>) {
        
        switch result {
        case .success(let data):
            self.userData += data
            print("\(#function) success \(self.userData)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .failure(let error):
            print("\(#function) failure \(error.localizedDescription)")
        }
    }
    
    func setupUserData(result: Result<User.Detail,Error>) {
        
        switch result {
        case .success(let data):
            self.selectedUser = data
            print("\(#function) success \(self.selectedUser)")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showDetail", sender: nil)
            }
        case .failure(let error):
            print("\(#function) failure \(error.localizedDescription)")
        }
    }
}

extension UsersViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userData.count > 0 {
            tableView.separatorStyle = .singleLine
        }else {
            tableView.separatorStyle = .none
        }
        
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserCell.self)", for: indexPath) as? UserCell
        else {
            return UITableViewCell()
        }
        
        cell.set(data: userData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = userData[indexPath.row]
        userManager.sendRequest(addPath:"/\(selectedData.login)",method: .get, reponse: User.Detail.self, completion: setupUserData(result:))
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        fetchData()
    }
    
}
