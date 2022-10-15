//
//  ViewController.swift
//  UIKit06_OnBoardingView
//
//  Created by 이준형 on 2022/10/11.
//

import UIKit

class ViewController: UIViewController {
    
    var didShowOnboardingView = false
    let onboardingViewButton = UIButton()   // 이거는 그냥 추가로 한 번 만들어봄
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeOnboardingViewButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        if !didShowOnboardingView {
            showOnboardingView()
            didShowOnboardingView = true
        }
    }
    
    func makeOnboardingViewButton() {
        onboardingViewButton.setTitle("온보딩 보기", for: .normal)
        onboardingViewButton.setTitleColor(.black, for: .normal)
        onboardingViewButton.backgroundColor = .systemBlue
        onboardingViewButton.addTarget(self, action: #selector(showOnboardingView), for: .touchUpInside)
        self.view.addSubview(onboardingViewButton)
        
        onboardingViewButton.translatesAutoresizingMaskIntoConstraints = false
        onboardingViewButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        onboardingViewButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        onboardingViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        onboardingViewButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc func showOnboardingView() {
        let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        pageVC.modalPresentationStyle = .fullScreen
        self.present(pageVC, animated: true, completion: nil)
    }
}

