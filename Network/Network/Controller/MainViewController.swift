//
//  MainViewController.swift
//  Network
//
//  Created by Nikolai Sokol on 01.06.2021.
//

import UIKit

final class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {

    private let networkService: NewsNetworkServiceProtocol
    
    private var choosenCountry = "us" {
        didSet {
            countryButton.setTitle(choosenCountry.uppercased() + " ∨", for: .normal)
            loadNews()
        }
    }
    private var choosenCategory = "General" {
        didSet {
            categoryButton.setTitle(choosenCategory + " ∨", for: .normal)
            loadNews()
        }
    }

    init(networkService: NewsNetworkServiceProtocol) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var countryButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setTitle(choosenCountry.uppercased() + " ∨", for: .normal)
        button.addTarget(self, action: #selector(chooseCountry), for: .touchUpInside)
        return button
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setTitle(choosenCategory + " ∨", for: .normal)
        button.addTarget(self, action: #selector(chooseCategory), for: .touchUpInside)
        return button
    }()
    
    private var news = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        
        let countryButton = UIBarButtonItem(customView: countryButton)
        let categoryButton = UIBarButtonItem(customView: categoryButton)
        navigationItem.setLeftBarButtonItems([countryButton, categoryButton], animated: true)
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                title: "Refresh",
                style: .plain,
                target: self,
                action: #selector(loadNews)
            ), animated: true
        )
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        setupAutoLayout()
        
        loadNews()
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func loadNews() {
        activityIndicator.startAnimating()
        networkService.getNews(country: choosenCountry, category: choosenCategory) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.news = news
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                case .failure:
                    let alert = UIAlertController(title: "Loading Error", message: "Couldn't load News", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default) { _ in
                        self.loadNews()
                    })
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func chooseCountry() {
        showPopover(items: NewsParameters.countries) { country in
            self.choosenCountry = country
        }
    }
    
    @objc private func chooseCategory() {
        showPopover(items: NewsParameters.categories) { category in
            self.choosenCategory = category
        }
    }
    
    private func showPopover(items: [String], completion: @escaping((String) -> Void)) {
        let parametersController = ParametersViewController(items: items)
        parametersController.modalPresentationStyle = .popover
        
        let popoverPresentationController = parametersController.popoverPresentationController
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.delegate = self
        popoverPresentationController?.sourceRect = CGRect(x: 100, y: 100, width: 0, height: 0)
        parametersController.preferredContentSize = CGSize(width: view.frame.width / 2, height: view.frame.height / 2)
        present(parametersController, animated: true, completion: nil)
        
        parametersController.selectedItem = { [weak self] item in
            guard let self = self else { return }
            completion(item)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell
        else { preconditionFailure("Failed to load table view cell") }
        
        var title = news[indexPath.row].title
        if let afterDash = title.range(of: " - ") {
            title.removeSubrange(afterDash.lowerBound..<title.endIndex)
        }
        cell.setTitle(title)
        
        cell.setDescription(news[indexPath.row].description ?? "")
        
        if let imageURL = news[indexPath.row].urlToImage {
            networkService.loadImage(imageUrl: imageURL) { image in
                DispatchQueue.main.async {
                    cell.setImage(image)
                }
            }
        } else {
            cell.setImage(UIImage(named: "noImage") ?? UIImage())
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedController = DetailedNewsViewController(
            networkService: networkService,
            newsImageUrl: news[indexPath.row].urlToImage ?? "",
            newsTitle: news[indexPath.row].title,
            newsContent: news[indexPath.row].content ?? "",
            newsSource: news[indexPath.row].urlToSource
        )
        navigationController?.pushViewController(detailedController, animated: true)
    }
}

