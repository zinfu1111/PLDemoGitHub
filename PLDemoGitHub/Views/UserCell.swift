//
//  UserCell.swift
//  PLDemoGitHub
//
//  Created by 連振甫 on 2021/9/20.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    private var data:User.List!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(data: User.List){
        self.data = data
        self.loginLabel.text = data.login
        self.typeLabel.text = data.type
        downloadPhoto()
    }
    
    func downloadPhoto() {
        let id = data.id
        PhotoManager.shared.downloadImage(url: data.avatar_url) { [weak self] image in
            DispatchQueue.main.async {
                guard let self = self,self.data.id == id else { return }
                self.photoImageView.image = image
            }
        }
    }

}
