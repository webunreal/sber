//
//  FiltersLikeInInstagramCollectionViewCell.swift
//  CameraFilters
//
//  Created by Nikolai Sokol on 08.06.2021.
//

import UIKit

final class FiltersLikeInInstagramCollectionViewCell: UICollectionViewCell {
    
    public static let reuseIdentifier = "FiltersLikeInInstagramCollectionViewCell"
    
    private lazy var filteredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var filterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? 2: 0
            layer.borderColor = UIColor.systemPink.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        autoresizesSubviews = true
        
        addSubview(filteredImageView)
        filteredImageView.addSubview(filterNameLabel)
        
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            filteredImageView.topAnchor.constraint(equalTo: topAnchor),
            filteredImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filteredImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filteredImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            filterNameLabel.leadingAnchor.constraint(equalTo: filteredImageView.leadingAnchor, constant: 20),
            filterNameLabel.trailingAnchor.constraint(equalTo: filteredImageView.trailingAnchor, constant: -20),
            filterNameLabel.bottomAnchor.constraint(equalTo: filteredImageView.bottomAnchor, constant: -5)
        ])
    }
    
    public func setImage(_ image: UIImage) {
        filteredImageView.image = image
    }
    
    public func setFolterName(_ name: String) {
        filterNameLabel.text = name
    }
}
