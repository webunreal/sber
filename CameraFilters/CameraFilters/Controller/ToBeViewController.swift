//
//  ToBeViewController.swift
//  CameraFilters
//
//  Created by Nikolai Sokol on 08.06.2021.
//

import UIKit

final class ToBeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    private let filterManager: FilterManager
    
    private var chosenImage: UIImage? = UIImage() {
        didSet {
            filterCarouselView.setImage(chosenImage)
        }
    }
    
    private var chosenFilter = "CIBloom" {
        didSet {
            title = chosenFilter
            intensity = 0.5
        }
    }
    
    private var intensity: CGFloat = 0.5 {
        didSet {
            applyFilter()
        }
    }
    
    private lazy var preferencesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(openPreferences) , for: .touchUpInside)
        return button
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()
    
    private lazy var filterImageView: UIImageView = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(chooseImage))
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "plus.viewfinder")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var filterCarouselView: FiltersLikeInInstagramView = {
        let view = FiltersLikeInInstagramView(frame: .zero, filterManager: filterManager)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(filterManager: FilterManager) {
        self.filterManager = filterManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let preferences = UIBarButtonItem(customView: preferencesButton)
        navigationItem.setRightBarButton(preferences, animated: true)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(filterImageView)
        view.addSubview(filterCarouselView)
        
        setupAutoLayout()
        
        filterCarouselView.selectedFilter = { [weak self] filter in
            guard let self = self else { return }
            self.chosenFilter = filter
        }
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            filterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            filterImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            filterImageView.bottomAnchor.constraint(equalTo: filterCarouselView.topAnchor, constant: -20),
            
            filterCarouselView.heightAnchor.constraint(equalToConstant: 150),
            filterCarouselView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            filterCarouselView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            filterCarouselView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func openPreferences() {
        let preferencesController = PreferencesViewController()
        preferencesController.modalPresentationStyle = .popover
        preferencesController.setupSliderValue(intensity)
        
        let popoverPresentationController = preferencesController.popoverPresentationController
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.delegate = self
        popoverPresentationController?.sourceRect = CGRect(x: view.frame.maxX, y: view.safeAreaInsets.top, width: 0, height: 0)
        preferencesController.preferredContentSize = CGSize(width: view.frame.width, height: view.frame.height / 5)
        present(preferencesController, animated: true, completion: nil)
        
        preferencesController.intensity = { [weak self] intensity in
            guard let self = self else { return }
            self.intensity = intensity
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        true
    }
    
    @objc private func chooseImage() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func applyFilter() {
        guard  let image = chosenImage else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.filterImageView.image = self.filterManager.applyFilter(image: image, filterName: self.chosenFilter, intensity: self.intensity)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        chosenImage = image
        filterImageView.image = image
        title = chosenFilter
        navigationItem.rightBarButtonItem?.isEnabled = true
        applyFilter()
        
        dismiss(animated: true, completion: nil)
    }
}
