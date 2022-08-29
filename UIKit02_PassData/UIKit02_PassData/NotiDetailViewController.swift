//
//  NotiDetailViewController.swift
//  UIKit02_PassData
//
//  Created by 이준형 on 2022/08/29.
//

import UIKit

class NotiDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func notiAction(_ sender: Any) {
        let notificationName = Notification.Name("sendSomeString")
        let strDic = ["str" : "noti string"]
        
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: strDic)
        // 호출을 한 번해도 여러번 등록되어 있으면 여러번 실행됨.
        self.dismiss(animated: true)
    }
    
}
