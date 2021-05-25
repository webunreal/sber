//
//  PlaceViewController.swift
//  UITableView
//
//  Created by Nikolai Sokol on 25.05.2021.
//

import UIKit

class PlaceViewController: UIViewController {
    
    public let placeName: String
    
    private lazy var placeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .black
        return label
    }()
    
    init(placeName: String) {
        self.placeName = placeName
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(placeNameLabel)
        placeNameLabel.text = placeName
        
        NSLayoutConstraint.activate([
            placeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
