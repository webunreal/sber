//
//  CircleView.swift
//  UIKitLesson2
//
//  Created by Nikolai Ivanov on 15.05.2021.
//

import UIKit

class CircleView: UIView {
    
    convenience init(diameter: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        layer.cornerRadius = diameter / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint,with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view === self {
            return nil
        }
        return view
    }
}
