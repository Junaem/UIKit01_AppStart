//
//  DraggableView.swift
//  UIKit05_PanGesture_App
//
//  Created by 이준형 on 2022/10/09.
//

import UIKit

class DraggableView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dragging(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            print("began")
        case .changed:
            let delta = pan.translation(in: self.superview)
            var myPosition = self.center
            
            myPosition.x += delta.x
            myPosition.y += delta.y
            self.center = myPosition
            
            pan.setTranslation(CGPoint.zero, in: self.superview)
            // delta의 움직임을 초기화 시켜줘야 움직인 값이 중복으로 더해지지 않음
            
        case .ended, .cancelled:
            print("ended canclled")
        default:
            break
        }
    }
}
