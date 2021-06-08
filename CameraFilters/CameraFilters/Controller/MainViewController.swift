//
//  MainViewController.swift
//  CameraFilters
//
//  Created by Nikolai Sokol on 08.06.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let filterManager = FilterManager()
    
    private lazy var asIsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("As IS", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showAsIsController) , for: .touchUpInside)
        return button
    }()
    
    private lazy var toBeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("To Be", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showToBeController) , for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(asIsButton)
        view.addSubview(toBeButton)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            asIsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            asIsButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            asIsButton.widthAnchor.constraint(equalToConstant: 100),
            asIsButton.heightAnchor.constraint(equalToConstant: 50),
            
            toBeButton.topAnchor.constraint(equalTo: asIsButton.bottomAnchor, constant: 50),
            toBeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            toBeButton.widthAnchor.constraint(equalToConstant: 100),
            toBeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func showAsIsController() {
        let asIsController = AsIsViewController(filterManager: filterManager)
        pushController(asIsController)
    }
    
    @objc private func showToBeController() {
        let toBeController = ToBeViewController(filterManager: filterManager)
        pushController(toBeController)
    }
    
    private func pushController(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}

