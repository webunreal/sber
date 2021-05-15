//
//  SecondViewController.swift
//  UIKitLesson2
//
//  Created by Deniz Kaplan on 14.05.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    
    lazy var bagel: CircleView = {
        let view = CircleView(diameter: self.view.frame.height / 2.5)
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.cornerRadius = view.layer.cornerRadius
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        return view
    }()
    
    lazy var responderButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(responderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var bagelHole: CircleView = {
        let view = CircleView(diameter: self.view.frame.height / 4.5)
        view.backgroundColor = self.view.backgroundColor
        return view
    }()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .green
        view.addSubview(bagel)
        view.addSubview(responderButton)
        view.addSubview(bagelHole)
	}
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        responderButton.frame = bagelHole.frame
        bagel.center = view.center
        responderButton.center = view.center
        bagelHole.center = view.center
    }
    
    @objc func responderButtonTapped() {
        print("Responder Button Tapped")
    }
}
