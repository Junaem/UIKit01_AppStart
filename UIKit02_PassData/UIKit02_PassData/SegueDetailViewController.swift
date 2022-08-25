//
//  SegueDetailViewController.swift
//  UIKit02_PassData
//
//  Created by 이준형 on 2022/08/25.
//

import UIKit

class SegueDetailViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataLabel.text = dataString
    }
    

}
