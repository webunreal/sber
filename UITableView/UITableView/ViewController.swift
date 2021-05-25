//
//  ViewController.swift
//  UITableView
//
//  Created by Nikolai Sokol on 25.05.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellReusableIdentifier = "TableViewCell"
    private let places: [String] = [
        "New Zealand",
        "Paris",
        "Bora Bora",
        "Maui",
        "Tahiti",
        "London",
        "Rome",
        "Phuket"
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        setupAutoLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self as AnyClass, forCellReuseIdentifier: cellReusableIdentifier)
        
        navigationController?.navigationBar.barTintColor = .lightGray
        title = "Places"
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReusableIdentifier, for: indexPath) as? TableViewCell
        else { return UITableViewCell(style: .default, reuseIdentifier: "") }
        
        cell.placeNameLabel.text = places[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeViewController = PlaceViewController(placeName: places[indexPath.row])
        navigationController?.pushViewController(placeViewController, animated: true)
    }
}

