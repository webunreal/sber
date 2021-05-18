//
//  CustomUIActivity.swift
//  UIViewControllerLesson
//
//  Created by Nikolai Sokol on 18.05.2021.
//

import UIKit

final class CustomUIActivity: UIActivity {
    
    override class var activityCategory: Category { .share }
    override var activityType: UIActivity.ActivityType? { .myActivity }
    override var activityTitle: String? { "Yeah, activity!" }
    override var activityImage: UIImage? { UIImage(named: "sber") }
    
    override var activityViewController: UIViewController? {
        let alert = UIAlertController(title: "Yeah, activities!", message: "Nice job", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yep", style: .default) { [weak self] _ in
            alert.dismiss(animated: true)
            self?.activityDidFinish(true)
        })
        return alert
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        true
    }
}

extension UIActivity.ActivityType {
    public static let myActivity = UIActivity.ActivityType(rawValue: "my_activity")
}
