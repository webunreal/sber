//
//  NewsTableViewCell.swift
//  Network
//
//  Created by Nikolai Sokol on 01.06.2021.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    public static let identifier = "NewsTableViewCell"
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsDescriptionLabel)
        contentView.addSubview(newsImageView)

        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            newsDescriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 10),
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -10),
            newsDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            newsImageView.leadingAnchor.constraint(equalTo: newsTitleLabel.trailingAnchor, constant: 10),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            newsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            newsImageView.widthAnchor.constraint(equalToConstant: 150),
            newsImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    public func setTitle(_ title: String) {
        newsTitleLabel.text = title
    }
    
    public func setDescription(_ description: String) {
        newsDescriptionLabel.text = description
    }
    
    public func setImage(_ image: UIImage) {
        newsImageView.image = image
    }
}
