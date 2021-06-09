//
//  BagelView.swift
//  UIKitLesson2
//
//  Created by Nikolai Ivanov on 15.05.2021.
//

import UIKit

class BagelView: UIView {
    
    private var holeDiameter: CGFloat = 0
    
    private var holeRect = CGRect.zero
    
    convenience init(diameter: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        layer.cornerRadius = diameter / 2
        holeDiameter = diameter / 2.5
        holeRect = CGRect(x: bounds.midX - holeDiameter / 2, y: bounds.midY - holeDiameter / 2, width: holeDiameter, height: holeDiameter)
        
        makeHole()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeHole() {
        let path = CGMutablePath()
        path.addEllipse(in: holeRect)
        path.addRect(CGRect(origin: .zero, size: frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        
        layer.mask = maskLayer
        clipsToBounds = true
    }
    
    override func hitTest(_ point: CGPoint,with event: UIEvent?) -> UIView? {
        if checkPoint(point) {
            return super.hitTest(point, with: event)
        }
        return nil
    }
    
    private func checkPoint(_ point: CGPoint) -> Bool {
        let holePath = UIBezierPath(ovalIn: holeRect)
        let bagelPath = UIBezierPath(ovalIn: bounds)
        if !holePath.contains(point) && bagelPath.contains(point) {
            return true
        }
        return false
    }
}
