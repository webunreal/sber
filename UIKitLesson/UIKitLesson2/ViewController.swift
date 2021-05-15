//
//  ViewController.swift
//  UIKitLesson2
//
//  Created by Deniz Kaplan on 14.05.2021.
//

import UIKit

class ViewController: UIViewController {

	lazy var infoBlock: InfoBlockView = {
		let view = InfoBlockView(text: "Hello bla bla bla bla")
		view.backgroundColor = .gray
		return view
	}()

	lazy var gradientView: GradientView = {
		let view = GradientView(frame: .zero)
		return view
	}()

	lazy var tapGesture: UITapGestureRecognizer = {
		let recognizer = UITapGestureRecognizer()
		recognizer.addTarget(self, action: #selector(viewTapped))
		return recognizer
	}()

	lazy var button: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("ViewController2", for: .normal)
		button.titleLabel?.textAlignment = .center
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		view.addSubview(infoBlock)
		view.addSubview(gradientView)
		view.addSubview(button)
		gradientView.colors = [.black, .blue, .brown]
		gradientView.addGestureRecognizer(tapGesture)
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		infoBlock.frame = .init(x: 0, y: 0, width: 200, height: 200)
		infoBlock.center = view.center
		gradientView.frame = .init(x: 0, y: 0, width: 300, height: 300)
		gradientView.center = view.center
		button.frame = .init(x: view.frame.width / 2 - 75, y: view.frame.height - 100, width: 150, height: 44)
	}

	@objc func viewTapped() {
		gradientView.colors = [.red, .orange]
	}

	@objc func buttonTapped() {
		navigationController?.pushViewController(SecondViewController(), animated: true)
	}
}



