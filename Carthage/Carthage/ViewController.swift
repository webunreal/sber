//
//  ViewController.swift
//  Carthage
//
//  Created by Nikolai Sokol on 09.06.2021.
//

import UIKit
import SberCarthageFramework

class ViewController: Something {
    
    private lazy var changeColorButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Color", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(changeColor) , for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(changeColorButton)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            changeColorButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            changeColorButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            changeColorButton.widthAnchor.constraint(equalToConstant: 200),
            changeColorButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func changeColor() {
        changeBackgroundColorColor(.systemPink)
        changeColorButton.setTitle("It works", for: .normal)
        changeColorButton.isEnabled = false
    }
}

