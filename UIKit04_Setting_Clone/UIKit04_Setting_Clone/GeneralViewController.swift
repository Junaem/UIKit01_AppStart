//
//  GeneralViewController.swift
//  UIKit04_Setting_Clone
//
//  Created by 이준형 on 2022/09/26.
//

import UIKit


class GeneralCell: UITableViewCell {
    
    @IBOutlet weak var leftLable: UILabel!
    @IBOutlet weak var rightImageView: UIImageView! {
        didSet{
            rightImageView.image = UIImage.init(systemName: "chevron.right")
        }
    }
}



class GeneralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

    @IBOutlet weak var generalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generalTableView.delegate = self
        generalTableView.dataSource = self
        
    }
    


}
