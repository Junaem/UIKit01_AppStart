//
//  DetailViewController.swift
//  UIKit02_PassData
//
//  Created by 이준형 on 2022/08/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var someString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someLabel.text = someString

    }
    @IBOutlet weak var someLabel: UILabel!
    
}
