//
//  FiltersTableViewCell.swift
//  CameraFilters
//
//  Created by Nikolai Sokol on 08.06.2021.
//

import UIKit

final class FiltersTableViewCell: UITableViewCell {
    
    public static let reuseIdentifier = "FiltersTableViewCell"
    
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(filterLabel)
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    public func setFilterName(_ name: String) {
        filterLabel.text = name
    }
}
