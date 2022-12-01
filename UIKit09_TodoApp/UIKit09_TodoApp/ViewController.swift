//
//  ViewController.swift
//  UIKit09_TodoApp
//
//  Created by 이준형 on 2022/11/15.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var todoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To do List"    // 네비게이션 바 이름
        makeNavigationBar()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        
    }
    
    func makeNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        addButton.tintColor = .tintColor
        self.navigationItem.rightBarButtonItem = addButton
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .blue.withAlphaComponent(0.2)
        
        self.navigationController?.navigationBar.standardAppearance = barAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        // 배경색이 안 변함, 2의 7분 50초
        // iOS 15부터 동작 방식이 변해서 scrollEdgeAppearance도 같이 변경해줘야 작동함
    }
    
    

    @objc func addNewTodo() {
        
    }

    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        return cell
    }
    
    
}

