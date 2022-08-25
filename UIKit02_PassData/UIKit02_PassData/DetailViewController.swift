//
//  DetailViewController.swift
//  UIKit02_PassData
//
//  Created by 이준형 on 2022/08/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var someString = ""
    
    @IBOutlet weak var someLabel: UILabel!
    // 최초 클래스(VC) 생성시에는 nil임(없음)
    // View가 Load가 되었을때 생김.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someLabel.text = someString

    }
    
}
