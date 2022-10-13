//
//  OnBoardingPageViewController.swift
//  UIKit06_OnBoardingView
//
//  Created by 이준형 on 2022/10/11.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    
    func makePageVC() {
        let itemVC1 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC1.mainText = "What is Lorem Ipsum?"
        itemVC1.subText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        itemVC1.topImage = UIImage(named: "onboarding1")
        
        let itemVC2 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC2.mainText = "Where does it come from?"
        itemVC2.subText = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."
        itemVC2.topImage = UIImage(named: "onboarding2")
        
        let itemVC3 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC3.mainText = "Where can I get some?"
        itemVC3.subText = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."
        itemVC3.topImage = UIImage(named: "onboarding3")
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        setViewControllers([itemVC1], direction: .forward, animated: true)
        self.dataSource = self
//        self.delegate = self
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makePageVC()
        makeBottomButton()
        
        func makeBottomButton() {
            let button = UIButton()
            button.setTitle("확인", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .systemBlue
            button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
//            button.titleLabel?.font = .systemFont(ofSize: 20)
            self.view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true // contant를 0으로 줄 때는 생략 가능
            button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        }
    }
    
    @objc func dismissPageVC() {
        self.dismiss(animated: true, completion: nil)
    }


}

extension OnBoardingPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil // guard else를 사용해, 인덱스를 못 찾으면 그냥 nil을 리턴
        }
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil // guard를 사용해, 인덱스를 못 찾으면 그냥 nil을 리턴
        }
        if currentIndex == pages.count - 1 {
            return pages.first
        } else {
            return pages[currentIndex + 1]
        }
    }
    
    
}


extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        
        
    }
}
