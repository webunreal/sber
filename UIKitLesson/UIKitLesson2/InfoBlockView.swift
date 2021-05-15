//
//  InfoBlockView.swift
//  UIKitLesson2
//
//  Created by Deniz Kaplan on 14.05.2021.
//

import UIKit

final class InfoBlockView: UIView {

	var text: String = "" {
		didSet {
			textLabel.text = text
		}
	}

	private let textLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.textAlignment = .center
		label.numberOfLines = 0
		label.textColor = .black
		return label
	}()

	convenience init(text: String) {
		self.init(frame: .zero)
		textLabel.text = text
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(textLabel)
		layer.cornerRadius = 20
		textLabel.center = center
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		textLabel.frame = .init(x: 0, y: 0, width: bounds.width, height: bounds.height)
	}

	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view
	}
}
