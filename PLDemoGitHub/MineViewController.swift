//
//  MineViewController.swift
//  PLDemoGitHub
//
//  Created by 連振甫 on 2021/9/19.
//

import UIKit

class MineViewController: BaseViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.width/2
    }

    
    /// 設定追蹤人數
    /// - Parameters:
    ///   - followers: 關注者
    ///   - following: 正在關注
    func setupFollowLabel(followers:String,following:String) {
        
        let text = "\(followers)followers·\(following)following"
        
        //TODO: set icon
        let icon = NSTextAttachment()
        icon.image = UIImage(systemName: "person.2")
        icon.bounds = CGRect(x: 0, y: -5, width: 25, height: 20)
        let iconString = NSAttributedString(attachment: icon)
        
        //TODO: set Attribute
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        let regularAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                 NSAttributedString.Key.paragraphStyle : paragraphStyle,
                                 NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let largeAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                               NSAttributedString.Key.paragraphStyle : paragraphStyle,
                               NSAttributedString.Key.foregroundColor: UIColor.black]
        
        //TODO: set content
        let content = NSMutableAttributedString(attributedString: iconString)
        
        let attributedSentence = NSMutableAttributedString(string: text, attributes: regularAttributes)
        content.append(attributedSentence)
        
        //TODO: set Attributes
        content.setAttributes(largeAttributes, range: NSRange(location: 1, length: followers.count))
        content.setAttributes(largeAttributes, range: NSRange(location: 1+followers.count+10, length: following.count))
        
        //TODO: set text
        followLabel.attributedText = content
    }
    
    
    /// 設定信箱
    /// - Parameters:
    ///   - mail: 信箱
    func setupEmailLabel(mail:String) {
        
        let text = "\(mail)"
        
        //TODO: set icon
        let icon = NSTextAttachment()
        icon.image = UIImage(systemName: "mail")
        icon.bounds = CGRect(x: 0, y: -5, width: 25, height: 20)
        let iconString = NSAttributedString(attachment: icon)
        
        //TODO: set Attribute
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        let regularAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                               NSAttributedString.Key.paragraphStyle : paragraphStyle,
                               NSAttributedString.Key.foregroundColor: UIColor.black]
        
        //TODO: set content
        let content = NSMutableAttributedString(attributedString: iconString)
        
        let attributedSentence = NSMutableAttributedString(string: text, attributes: regularAttributes)
        content.append(attributedSentence)
        
        
        //TODO: set text
        emailLabel.attributedText = content
    }
}
