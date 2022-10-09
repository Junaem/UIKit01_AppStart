//
//  ViewController.swift
//  UIKit05_PanGesture_App
//
//  Created by 이준형 on 2022/10/09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = DraggableView()
        
        myView.center = self.view.center
        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.backgroundColor = .green
        
        self.view.addSubview(myView)
    }


}

