//
//  ViewController.swift
//  Animations
//
//  Created by Nikolai Sokol on 24.05.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Repeat", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(repeatAnimation), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawTree()
        addButton()
    }
    
    private func addButton() {
        view.addSubview(self.button)
        button.frame = CGRect(x: view.frame.width / 2 - 100, y: 50, width: 200, height: 50)
    }
    
    private func drawTree() {
        var trunkPaths: [UIBezierPath] = []
        var branchesPaths: [UIBezierPath] = []
        let trunkWidth = view.frame.width / 7
        let branchWidth = view.frame.width / 25
        
        // MARK: - Stump
        let stumpStartPoint = CGPoint(x: view.frame.midX, y: view.frame.height)
        let stumpEndPoint = CGPoint(x: view.frame.midX, y: view.frame.height / 1.1)
        let stumpPath = createPath(startPoint: stumpStartPoint, endPoint: stumpEndPoint, isCurved: false)
        trunkPaths.append(stumpPath)
        
        // MARK: - Trunk
        let trunkStartPoint = CGPoint(x: stumpEndPoint.x, y: stumpEndPoint.y + 20)
        let trunkEndPoint = CGPoint(x: trunkStartPoint.x, y: view.frame.height / 1.5)
        let trunkPath = createPath(startPoint: trunkStartPoint, endPoint: trunkEndPoint, isCurved: true)
        trunkPaths.append(trunkPath)
        
        // MARK: - Branches
        let branchStartPoint1 = CGPoint(x: trunkEndPoint.x, y: trunkEndPoint.y + 20)
        let branchEndPoint1 = CGPoint(x: view.frame.minX + 50, y: view.frame.height / 1.3)
        let branchPath1 = createPath(startPoint: branchStartPoint1, endPoint: branchEndPoint1, isCurved: true)
        branchesPaths.append(branchPath1)
        
        let branchStartPoint2 = CGPoint(x: trunkEndPoint.x, y: trunkEndPoint.y + 20)
        let branchEndPoint2 = CGPoint(x: view.frame.minX + 60, y: view.frame.height / 2)
        let branchPath2 = createPath(startPoint: branchStartPoint2, endPoint: branchEndPoint2, isCurved: true)
        branchesPaths.append(branchPath2)
        
        let branchStartPoint3 = CGPoint(x: trunkEndPoint.x, y: trunkEndPoint.y + 20)
        let branchEndPoint3 = CGPoint(x: view.frame.width - 50, y: view.frame.height / 1.4)
        let branchPath3 = createPath(startPoint: branchStartPoint3, endPoint: branchEndPoint3, isCurved: true)
        branchesPaths.append(branchPath3)
        
        let branchStartPoint4 = CGPoint(x: trunkEndPoint.x, y: trunkEndPoint.y + 20)
        let branchEndPoint4 = CGPoint(x: view.frame.width - 70, y: view.frame.height / 1.9)
        let branchPath4 = createPath(startPoint: branchStartPoint4, endPoint: branchEndPoint4, isCurved: true)
        branchesPaths.append(branchPath4)
        
        let branchStartPoint5 = CGPoint(x: trunkEndPoint.x, y: trunkEndPoint.y + 20)
        let branchEndPoint5 = CGPoint(x: view.frame.midX - 10, y: view.frame.height / 2.2)
        let branchPath5 = createPath(startPoint: branchStartPoint5, endPoint: branchEndPoint5, isCurved: true)
        branchesPaths.append(branchPath5)
        
        // MARK: - Drawing
        drawLine(paths: trunkPaths, lineWidth: trunkWidth)
        drawLine(paths: branchesPaths, lineWidth: branchWidth)
        drawLeaves(centers: [branchEndPoint1, branchEndPoint2, branchEndPoint3, branchEndPoint4, branchEndPoint5, trunkEndPoint])
        drawApples(centers: [branchEndPoint1, branchEndPoint2, branchEndPoint3, branchEndPoint4, branchEndPoint5, trunkEndPoint])
    }
    
    private func createPath(startPoint: CGPoint, endPoint: CGPoint, isCurved: Bool) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        
        if isCurved {
            let curveCoefficient = view.frame.width / 6
            path.addCurve(
                to: endPoint,
                controlPoint1: CGPoint(x: endPoint.x - curveCoefficient, y: endPoint.y + curveCoefficient),
                controlPoint2: CGPoint(x: endPoint.x + curveCoefficient, y: endPoint.y - curveCoefficient * 2)
            )
        } else {
            path.addLine(to: endPoint)
        }
        return path
    }
    
    private func drawLine(paths: [UIBezierPath], lineWidth: CGFloat) {
        let path = UIBezierPath()
        for item in paths {
            path.append(item)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.brown.cgColor
        shapeLayer.lineWidth = lineWidth
        
        view.layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 2
        shapeLayer.add(animation, forKey: nil)
    }
    
    private func drawLeaves(centers: [CGPoint]) {
        let path = UIBezierPath()
        for item in centers {
            path.append(UIBezierPath(
                            arcCenter: item,
                            radius: view.frame.width / 5,
                            startAngle: 0,
                            endAngle: CGFloat(Double.pi * 2),
                            clockwise: true))
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.green.cgColor
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.opacity = 0
        
        view.layer.addSublayer(shapeLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 1
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isRemovedOnCompletion = false
            shapeLayer.add(animation, forKey: nil)
        }
    }
    
    private func drawApples(centers: [CGPoint]) {
        let path = UIBezierPath()
        for item in centers {
            path.append(UIBezierPath(
                            arcCenter: CGPoint(x: item.x + 10, y: item.y - 20),
                            radius: view.frame.width / 18,
                            startAngle: 0,
                            endAngle: CGFloat(Double.pi * 2),
                            clockwise: true))
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.opacity = 0
        
        view.layer.addSublayer(shapeLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 1
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isRemovedOnCompletion = false
            shapeLayer.add(animation, forKey: nil)
        }
    }
    
    @objc private func repeatAnimation() {
        view.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        addButton()
        drawTree()
    }
}

