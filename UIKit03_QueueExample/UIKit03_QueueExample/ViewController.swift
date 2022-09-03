//
//  ViewController.swift
//  UIKit03_QueueExample
//
//  Created by 이준형 on 2022/09/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            
            self.timerLabel.text = Date().timeIntervalSince1970.description
        }
    }

    @IBAction func action1(_ sender: Any) {
        simpleClosure {
            DispatchQueue.main.async {
                self.finishLabel.text = "끝"
            }
            //  UI를 건드리는 로직은 반드시 main 스레드에서 실행되야함
        }
    }
    
    func simpleClosure(completion: @escaping() -> Void) {
        finishLabel.text = "시작"
        DispatchQueue.global().async {  // global로 스레드 하나 새로 열어서 거기서 작업 (비동기적)
            // 메인 스레드에서 이런 무거운 작업을 하면 다 멈춰버림. 라이프사이클이 메인 스레드에서 돌기 때문
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
//            DispatchQueue.main.async {
            completion()
//            }
        }
    }
    
    
    @IBAction func action2(_ sender: Any) {
        let dispatchGroup = DispatchGroup()
        
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        let queue3 = DispatchQueue(label: "q3")
        
        // qos로 우선순위를 설정해준다고 순서를 보장해주는건 아니지만 전체적으로 더 빠르게 실행됨.
        queue1.async(group: dispatchGroup, qos: DispatchQoS.background) {
            dispatchGroup.enter()   //  작업 중인거 하나 더 있다. - 작업상황 수동 관리
            DispatchQueue.global().async {
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()   //   작업 중인거 하나 끝났다
            }
        }
        
        queue2.async(group: dispatchGroup, qos: .userInteractive) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        queue3.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 20..<30 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("끝")
        }
    }
    
    
    @IBAction func action3(_ sender: Any) {
        
//        DispatchQueue.main.sync {
        //// 한 스레드가 끝나기 전에 거기다가 sync걸었을때 데드락 걸리는거임
////         작업이 끝날 일이 없는 메인스레드에다가 또 sync를 하면 무조건 데드락
//            print("main sync")
//        }
        
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        
        queue1.sync {   // 다른 스레드 다 락걸고 진행 (동기적)
            // sync는 굉장히 중요한 작업이어서 이게 끝날때 까지 다른 작업이 진행되면 안 될 때만 사용
            for idx in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(idx)
            }
//            queue1.sync {   // 데드락 -> 서로서로 계속 기다리는 상태.
//                // 바깥놈이 async여도 안에가 sync면 기존의 작업이 끝날때까지 기다려야 되는데, 자기 자신을 기다리는 거라 데드락에 걸림
//                for idx in 0..<10 {
//                    Thread.sleep(forTimeInterval: 0.2)
//                    print(idx)
//                }
//            }
        }
        
        queue2.sync {
            for idx in 10..<20 {
                Thread.sleep(forTimeInterval: 0.2)
                print(idx)
            }
        }
    }
}

