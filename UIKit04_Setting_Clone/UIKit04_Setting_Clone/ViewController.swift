//
//  ViewController.swift
//  UIKit04_Setting_Clone
//
//  Created by 이준형 on 2022/09/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    var settingModel = [[SettingModel]]()
    
    func makeData() {
        settingModel.append(
            [SettingModel(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iCloud, the App Store, and more.", rightImageName: nil)]
        )
        
        settingModel.append(
            [SettingModel(leftImageName: "gearshape", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),
            SettingModel(leftImageName: "figure.walk.circle", menuTitle: "Accessibility", subTitle: nil, rightImageName: "chevron.right"),
            SettingModel(leftImageName: "hand.raised.circle", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right")]
        )
        
    }
    
    let baseGray = UIColor(white: 230/255, alpha: 1)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeData()
        self.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = baseGray
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.backgroundColor = baseGray
        
        settingTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
    }

    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.topTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.profileImageView.image = UIImage(systemName:
                                                    settingModel[indexPath.section][indexPath.row].leftImageName)
            cell.profileImageView.tintColor = .systemBlue
            cell.bottomDescription.text = settingModel[indexPath.section][indexPath.row].subTitle
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.leftImageView.image = UIImage(systemName:
                                            settingModel[indexPath.section][indexPath.row].leftImageName)
        cell.leftImageView.tintColor = .systemBlue
        cell.midTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
        cell.rightImageView.image = UIImage(systemName:
                                                settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            if let generalVC = UIStoryboard(name: "GeneralViewController", bundle: nil).instantiateViewController(withIdentifier: "GeneralViewController") as? GeneralViewController {
                self.navigationController?.pushViewController(generalVC, animated: true)
            }
            
        }
    }
    

}
