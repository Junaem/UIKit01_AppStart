//
//  OnBoardingItemViewController.swift
//  UIKit06_OnBoardingView
//
//  Created by 이준형 on 2022/10/11.
//

import UIKit

class OnBoardingItemViewController: UIViewController {
    
    // IBOutlet으로 nib에서 가져오는 객체들은 클래스가 생성되고 조금 뒤에 생성된다.
    // 따라서 이 클래스의 인스턴스를 만들자마자 iboutlet값에 접근하면 nil이 나온다.
    
    // 외부에서 이 클래스를 생성했을때를 위해서 바로 접근할 수 있게 변수를 만들어놓고 연결
    var topImage: UIImage? = UIImage()
    var mainText = ""
    var subText = ""
    
    // 비슷한 이름의 변수가 있고, iboutlet 변수에 접근할 일은 없으므로 private화
    @IBOutlet private weak var topImageView: UIImageView!
    @IBOutlet private weak var mainTitleLabel: UILabel!{
        didSet {
            mainTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .systemFont(ofSize: 14, weight: .light)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topImageView.image = topImage
        mainTitleLabel.text = mainText
        descriptionLabel.text = subText
    }


}
