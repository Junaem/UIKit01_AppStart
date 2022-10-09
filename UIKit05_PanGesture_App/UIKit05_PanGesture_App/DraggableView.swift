//
//  DraggableView.swift
//  UIKit05_PanGesture_App
//
//  Created by 이준형 on 2022/10/09.
//

import UIKit

class DraggableView: UIView {
    
    var dragType: DragType = .none
    
    init() {
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder: NSCoder) {    // 인터페이스로 생성 가능하게 하는 init
        super.init(coder: coder)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
        
//        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dragging(pan: UIPanGestureRecognizer) {
        let mainVC = ViewController(nibName: "ViewController", bundle: nil)
        switch pan.state {
        case .began:
            print("began " + self.center.x.description + " " +  self.center.y.description)
            
        case .changed:
            let delta = pan.translation(in: self.superview)
            var myPosition = self.center
            
            if dragType == .x {
                myPosition.x += delta.x
            }
            else if dragType == .y  {
                myPosition.y += delta.y
            }
            else {
                myPosition.x += delta.x
                myPosition.y += delta.y
            }
            
            self.center = myPosition
            pan.setTranslation(CGPoint.zero, in: self.superview)
            // delta의 움직임을 초기화 시켜줘야 움직인 값이 중복으로 더해지지 않음
            
        case .ended, .cancelled:
            
            if self.frame.minX < 0 {
                self.frame.origin.x = 0
            }
            else if let hasSuperView = self.superview {
                if self.frame.maxX > hasSuperView.frame.maxX {
                    self.frame.origin.x = hasSuperView.frame.maxX - self.bounds.width
                }
            }
            
            print("ended canclled " + self.center.x.description + " " +  self.center.y.description)
        default:
            break
        }
    }
}
