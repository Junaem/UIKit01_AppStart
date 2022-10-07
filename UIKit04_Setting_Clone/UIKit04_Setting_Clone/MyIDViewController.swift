//
//  MyIDViewController.swift
//  UIKit04_Setting_Clone
//
//  Created by 이준형 on 2022/10/07.
//

import UIKit

class MyIDViewController: UIViewController {

    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이 클래스 안의 함수를 찾기 때문에 self
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    // selector에서 가져오기위해 objc
    @objc func textDidChange(sender: UITextField){
        if sender.text?.isEmpty == true {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
//        nextButton.isEnabled = !(sender.text ?? "").isEmpty
    }
    
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
