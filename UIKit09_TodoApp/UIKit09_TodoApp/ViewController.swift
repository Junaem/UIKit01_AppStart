//
//  ViewController.swift
//  UIKit09_TodoApp
//
//  Created by 이준형 on 2022/11/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To do List"    // 네비게이션 바 이름
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        addButton.tintColor = .tintColor
        self.navigationItem.rightBarButtonItem = addButton
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .blue
        
        self.navigationController?.navigationBar.standardAppearance = barAppearance
        // 배경색이 안 변함, 2의 7분 50초
        
    }
    
    @objc func addNewTodo() {
        
    }

    
}

