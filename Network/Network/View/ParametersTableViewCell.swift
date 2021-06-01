//
//  ParametersTableViewCell.swift
//  Network
//
//  Created by Nikolai Sokol on 01.06.2021.
//

import UIKit

final class ParametersTableViewCell: UITableViewCell {
    
    public static let identifier = "ParametersTableViewCell"
    
    private lazy var itemName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        contentView.addSubview(itemName)

        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            itemName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            itemName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            itemName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    public func setItemName(_ name: String) {
        itemName.text = name
    }
}
