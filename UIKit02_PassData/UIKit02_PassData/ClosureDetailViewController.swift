//
//  ClosureDetailViewController.swift
//  UIKit02_PassData
//
//  Created by 이준형 on 2022/08/29.
//

import UIKit

class ClosureDetailViewController: UIViewController {

    var myClosure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func closurePassData(_ sender: Any) {
        myClosure?("closure string")
        self.dismiss(animated: true)
    }
}
