//
//  FiltersViewController.swift
//  CameraFilters
//
//  Created by Nikolai Sokol on 08.06.2021.
//

import UIKit

final class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let filterManager: FilterManager
    public var chosenFilter: ((String) -> ())?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FiltersTableViewCell.self, forCellReuseIdentifier: FiltersTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(filterManager: FilterManager) {
        self.filterManager = filterManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenFilter?(filterManager.filters[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterManager.filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FiltersTableViewCell.reuseIdentifier, for: indexPath) as? FiltersTableViewCell
        else { preconditionFailure("Failed to load table view cell") }
        
        cell.setFilterName(filterManager.filters[indexPath.row])
        
        return cell
    }
}
