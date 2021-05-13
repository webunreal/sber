import UIKit

// Builder

final class CustomLabelBuilder {
    
    enum LabelStyle {
        case normal
        case title
        case description
        case link
    }
    
    func build(_ style: LabelStyle) -> UILabel {
        let label = UILabel()
        
        switch style {
        case .normal:
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 20)
        case .title:
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 30)
        case .description:
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 15)
        case .link:
            label.textColor = .blue
            label.font = UIFont.systemFont(ofSize: 20)
        }
        
        return label
    }
}

let builder = CustomLabelBuilder()
let label = builder.build(.title)


// Abstract Factory

final class EmloyerSignUpViewController: UIViewController {}

final class JobSeekerSignUpViewController: UIViewController {}

protocol SignUpViewControllerFactory {
    func makeEmployerSignUpViewController() -> UIViewController
    func makeJobSeekerSignUpViewController() -> UIViewController
}

struct SignUpViewController: SignUpViewControllerFactory {
    func makeEmployerSignUpViewController() -> UIViewController {
        EmloyerSignUpViewController()
    }
    
    func makeJobSeekerSignUpViewController() -> UIViewController {
        JobSeekerSignUpViewController()
    }
}

let factory = SignUpViewController()
let rootViewController = factory.makeJobSeekerSignUpViewController()
