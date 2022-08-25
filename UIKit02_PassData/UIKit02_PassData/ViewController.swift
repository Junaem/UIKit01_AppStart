//
//  ViewController.swift
//  UIKit02_PassData
//
//  Created by 이준형 on 2022/08/25.
//

import UIKit

// Passing Data (데이터를 넘겨주는 방법) - 6가지

// 1. instance property


class ViewController: UIViewController {

    var someString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveToDetail(_ sender: Any) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        detailVC.someString = "aaa"
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
}

