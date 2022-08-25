//
//  InstanceDetailViewController.swift
//  UIKit02_PassData
//
//  Created by 이준형 on 2022/08/25.
//

import UIKit

class InstanceDetailViewController: UIViewController {
    
    var mainVC: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendDataMainVc(_ sender: Any) {
        mainVC?.dataLabel.text = "some data"
        self.dismiss(animated: true, completion: nil)
    }
    

}
