//
//  DelegateDetailViewController.swift
//  UIKit02_PassData
//
//  Created by 이준형 on 2022/08/25.
//

import UIKit

protocol DelegateDetailViewControllerDelegate: AnyObject {
    func passString(string: String)
    
}

class DelegateDetailViewController: UIViewController {
    
    weak var delegate: DelegateDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func passDataToMainVC(_ sender: Any) {
        delegate?.passString(string: "delegate pass data")
        self.dismiss(animated: true)
    }
    
}
