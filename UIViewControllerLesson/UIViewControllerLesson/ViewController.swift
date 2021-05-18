//
//  ViewController.swift
//  UIViewControllerLesson
//
//  Created by Nikolai Sokol on 18.05.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "tmbiinw")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "navigationBarColor")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain,
            target: self,
            action: #selector(shareButtonTapped))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 50)
        ])
        
    }
    
    @objc private func shareButtonTapped() {
        guard let image = imageView.image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: [CustomUIActivity()])
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo
        ]

        present(activityViewController, animated: true)
    }
}

