//
//  UserDetailViewController.swift
//  PLDemoGitHub
//
//  Created by 連振甫 on 2021/9/20.
//

import UIKit

class UserDetailViewController: UITableViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    
    let userData:User.Detail
    
    init?(coder: NSCoder,userData:User.Detail) {
        self.userData = userData
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLabel()
        downloadPhoto()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.height/2
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension UserDetailViewController {
    
    private func setupLabel(){
        loginLabel.text = userData.login
        nameLabel.text = userData.name ?? ""
        locationLabel.text = userData.location ?? ""
        blogLabel.text = userData.blog?.absoluteString ?? ""
    }
    
    private func downloadPhoto(){
        PhotoManager.shared.downloadImage(url: userData.avatar_url) { [weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
            
        }
    }
}
