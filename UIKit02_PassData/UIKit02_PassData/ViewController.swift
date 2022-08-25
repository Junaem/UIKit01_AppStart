//
//  ViewController.swift
//  UIKit02_PassData
//
//  Created by 이준형 on 2022/08/25.
//

import UIKit

// Passing Data (데이터를 넘겨주는 방법) - 6가지

// 1. instance property
// 2. segue
// 3. instance
// 4. delegate (대리, 위임)

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 1. property
    @IBAction func moveToDetail(_ sender: Any) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        detailVC.someString = "aaa"
        
        // detailVC.someLabel.text = "bb"
        // 로드되기 전에는 someLabel이 nil이라서 에러남
        self.present(detailVC, animated: true, completion: nil)
        
        detailVC.someLabel.text = "bb"
        // 이러면 프레젠트(load)된 뒤에 설정하는 거라 가능
    }
    
    // 2. segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            if let detailVC = segue.destination as? SegueDetailViewController {
                detailVC.dataString = "abcd"
            }
        }
    }
    
    // 3. instance
    var someString = ""
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBAction func moveToInstance(_ sender: Any) {
        
        let instanceVC = InstanceDetailViewController(nibName: "InstanceDetailViewController", bundle: nil)
        
        instanceVC.mainVC = self
        self.present(instanceVC, animated: true)
    }
    
    // 4. delegate
    @IBAction func moveToDelegate(_ sender: Any) {
        let detailVC = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        detailVC.delegate = self
        self.present(detailVC, animated: true)
    }
    
}

// delegate의 프로토콜을 준수하기 위해
extension ViewController: DelegateDetailViewControllerDelegate {
    func passString(string: String) {
        self.dataLabel.text = string
    }
    
    
}
