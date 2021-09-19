//
//  BaseViewController.swift
//  PLDemoGitHub
//
//  Created by 連振甫 on 2021/9/19.
//

import UIKit

var user:User.Detail!

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(named: "Color-F6F6FA")
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0.0, width: 65.0, height: 45.0))
        titleLabel.text = "GitHub"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.backgroundColor = UIColor.clear
        let leftButton = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    

}
