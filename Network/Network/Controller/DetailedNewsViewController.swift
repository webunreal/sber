//
//  DetailedNewsViewController.swift
//  Network
//
//  Created by Nikolai Sokol on 01.06.2021.
//

import UIKit

final class DetailedNewsViewController: UIViewController {
    
    private let networkService: NewsNetworkServiceProtocol
    private let newsImageUrl: String
    private let newsTitle: String
    private var newsContent: String
    private let newsSource: String

    init(networkService: NewsNetworkServiceProtocol, newsImageUrl: String, newsTitle: String, newsContent: String, newsSource: String) {
        self.networkService = networkService
        self.newsImageUrl = newsImageUrl
        self.newsTitle = newsTitle
        self.newsContent = newsContent
        self.newsSource = newsSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var detailedView: DetailedNewsView = {
        let view = DetailedNewsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(detailedView)
        
        setupAutoLayout()
        setupView()
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            detailedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailedView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailedView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupView() {
        networkService.loadImage(imageUrl: newsImageUrl) { image in
            DispatchQueue.main.async {
                self.detailedView.setImage(image)
            }
        }
        
        detailedView.setTitle(newsTitle)
        
        if let afterDots = newsContent.range(of: "[") {
            newsContent.removeSubrange(afterDots.lowerBound..<newsContent.endIndex)
        }
        detailedView.setContent(newsContent)
        
        detailedView.openSourceLinkButton.addTarget(self, action: #selector(openSource), for: .touchUpInside)
    }
    
    @objc private func openSource() {
        let sourceController = SourceViewController(sourceUrl: newsSource)
        navigationController?.pushViewController(sourceController, animated: true)
    }
}
