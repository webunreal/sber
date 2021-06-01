//
//  DetailedNewsView.swift
//  Network
//
//  Created by Nikolai Sokol on 01.06.2021.
//

import UIKit

final class DetailedNewsView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var newsContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var openSourceLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Keep reading in Source", for: .normal)
        return button
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsContentLabel)
        contentView.addSubview(openSourceLinkButton)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            newsImageView.heightAnchor.constraint(equalToConstant: 300),
            
            newsTitleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 30),
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            newsContentLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 10),
            newsContentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            openSourceLinkButton.topAnchor.constraint(equalTo: newsContentLabel.bottomAnchor, constant: 20),
            openSourceLinkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            openSourceLinkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    public func setImage(_ image: UIImage) {
        newsImageView.image = image
    }
    
    public func setTitle(_ title: String) {
        newsTitleLabel.text = title
    }
    
    public func setContent(_ content: String) {
        newsContentLabel.text = content
    }
}
