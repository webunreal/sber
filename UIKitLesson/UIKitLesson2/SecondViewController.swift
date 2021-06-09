//
//  SecondViewController.swift
//  UIKitLesson2
//
//  Created by Deniz Kaplan on 14.05.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    
    private lazy var responderButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(responderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var bagel: BagelView = {
        let view = BagelView(diameter: self.view.frame.height / 2.5)
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.cornerRadius = view.layer.cornerRadius
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        return view
    }()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .green
        view.addSubview(responderButton)
        view.addSubview(bagel)
        
	}
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        responderButton.frame = bagel.frame
        bagel.center = view.center
        responderButton.center = view.center
    }
    
    @objc func responderButtonTapped() {
        print("Responder Button Tapped")
    }
}
