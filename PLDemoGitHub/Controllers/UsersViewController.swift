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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
    }
    
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        fetchData()
    }
    
}
