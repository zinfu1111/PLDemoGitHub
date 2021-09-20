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
    
    private var viewModel:User.List!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.height/2
    }
    
    func set(viewModel: User.List){
        self.viewModel = viewModel
        self.loginLabel.text = viewModel.login
        self.typeLabel.text = viewModel.type
        downloadPhoto()
    }
    
    private func downloadPhoto() {
        let id = viewModel.id
        PhotoManager.shared.downloadImage(url: viewModel.avatar_url) { [weak self] image in
            DispatchQueue.main.async {
                guard let self = self,self.viewModel.id == id else { return }
                self.photoImageView.image = image
            }
        }
    }

}
