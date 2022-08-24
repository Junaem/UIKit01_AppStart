//
//  ViewController.swift
//  App_start_UIKit
//
//  Created by 이준형 on 2022/08/25.
//

import UIKit
// 실행 - Cmd + R
class ViewController: UIViewController {

    @IBOutlet weak var testButton: UIButton!
    
    @IBAction func doSomething(_ sender: Any) {
        testButton.backgroundColor = UIColor.blue
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC")
        self.present(detailVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        testButton.backgroundColor = UIColor.red
    }
    
}


class DetailVC: UIViewController {
    
    // View Controller의 Life Cycle들
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
