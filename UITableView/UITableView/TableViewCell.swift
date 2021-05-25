//
//  TableViewCell.swift
//  UITableView
//
//  Created by Nikolai Sokol on 25.05.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private var beenInThisPlace = false
    
    public lazy var placeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    public lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        contentView.addSubview(placeNameLabel)
        contentView.addSubview(checkButton)
        
        setButtonTitle()
        
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            placeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            placeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            placeNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: placeNameLabel.trailingAnchor, constant: 30),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    @objc private func buttonTapped() {
        beenInThisPlace.toggle()
        setButtonTitle()
        changeBackgroundColor()
    }
    
    private func setButtonTitle() {
        checkButton.setTitle(beenInThisPlace ? "Haven't been" : "Been", for: .normal)
    }
    
    private func changeBackgroundColor() {
        contentView.backgroundColor = beenInThisPlace ? .cyan : .white
    }
}
