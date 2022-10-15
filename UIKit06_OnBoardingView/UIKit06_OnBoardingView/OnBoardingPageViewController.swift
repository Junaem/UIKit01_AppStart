//
//  OnBoardingPageViewController.swift
//  UIKit06_OnBoardingView
//
//  Created by 이준형 on 2022/10/11.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    var bottomButtonMargin: NSLayoutConstraint?
    var pageControl = UIPageControl()
//    let startIndex = 0
    var currentIndex = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }
    
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
        self.delegate = self
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makePageVC()
        makeBottomButton()
        makePageControl()
    }
    func makeBottomButton() {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
//            button.titleLabel?.font = .systemFont(ofSize: 20)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true // contant를 0으로 줄 때는 생략 가능
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomButtonMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtonMargin?.isActive = true
        hideButton()
    }
    
    
    func makePageControl() {
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false   // 오토레이아웃 쓰겠다.
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = currentIndex    // 이 값은 전역변수 currentIndex의 didSet으로 계속 변화함
//        pageControl.isUserInteractionEnabled = false    // 터치로 조작 불가하고 보여주기만 하고 싶을때
        
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        if sender.currentPage > self.currentIndex {
            setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        } else {
            setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true, completion: nil)
        }
        currentIndex = sender.currentPage
        buttonPresent()
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
        self.currentIndex = currentIndex    //  pageControl에 사용 - delegate에서 써서 안써도 되는듯
        
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
        self.currentIndex = currentIndex
        
        if currentIndex == pages.count - 1 {
            return pages.first
        } else {
            return pages[currentIndex + 1]
        }
    }
}


extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard let currentVC = pageViewController.viewControllers?.first else {
            return
        }

        guard let currentIndex = pages.firstIndex(of: currentVC) else {
            return
        }
        
        self.currentIndex = currentIndex
        buttonPresent()
    }
    
    func buttonPresent() {
        if currentIndex == pages.count - 1 {
            self.showButton()
        } else {
            self.hideButton()
        }
        
        // 밑에 거랑 같은 코드인데 completion으로 포지션 건드릴 필요가 없을 때 사용(밑에도 안 쓰긴 함)
        // self.view.layoutIfNeeded()로 현재 뷰에 화면 변화가 필요하면 애니메이션으로 보여줌(위에서 show/hideButton으로 화면 변화 됐을때)
//        UIView.animate(withDuration: 0.5) {
//            self.view.layoutIfNeeded()
//        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showButton() {
        bottomButtonMargin?.constant = 0
    }
    func hideButton() {
        bottomButtonMargin?.constant = 100
    }
}
