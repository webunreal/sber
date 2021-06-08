//
//  FiltersLikeInInstagramView.swift
//  CameraFilters
//
//  Created by Nikolai Sokol on 08.06.2021.
//

import UIKit

final class FiltersLikeInInstagramView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let filterManager: FilterManager
    private var image: UIImage?
    
    public var selectedFilter: ((String) -> ())?
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 150)
        flowLayout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FiltersLikeInInstagramCollectionViewCell.self, forCellWithReuseIdentifier: FiltersLikeInInstagramCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    init(frame: CGRect, filterManager: FilterManager) {
        self.filterManager = filterManager
        super.init(frame: frame)
        
        addSubview(collectionView)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilter?(filterManager.filters[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filterManager.filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiltersLikeInInstagramCollectionViewCell.reuseIdentifier, for: indexPath) as? FiltersLikeInInstagramCollectionViewCell
        else { preconditionFailure("Failed to load collection view cell") }
        
        if let cellImage = image {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                cell.setImage(self.filterManager.applyFilter(image: cellImage, filterName: self.filterManager.filters[indexPath.item], intensity: 0.5))
            }   
        }
        
        if image != nil {
            cell.setFolterName(filterManager.filters[indexPath.item])
        }
        
        return cell
    }
    
    public func setImage(_ image: UIImage?) {
        guard let newImage = image else { return }
        self.image = newImage
        collectionView.reloadData()
    }
}
