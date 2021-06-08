//
//  AsIsViewController.swift
//  CameraFilters
//
//  Created by Nikolai Sokol on 08.06.2021.
//

import UIKit

final class AsIsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    private let filterManager: FilterManager
    
    private var chosenFilter = "CIBloom" {
        didSet {
            title = chosenFilter
            chooseFilterButton.setTitle(chosenFilter, for: .normal)
            intensitySlider.setValue(0.5, animated: false)
            filterImageView.image = chosenImage
            applyFilter()
        }
    }
    
    private var chosenImage: UIImage? = UIImage()
    
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
    
    private lazy var intensityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Intensity"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var intensitySlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.setValue(0.5, animated: false)
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.isEnabled = false
        return slider
    }()
    
    private lazy var chooseFilterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choosen Filter"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var chooseFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(chosenFilter, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(chooseFilter) , for: .touchUpInside)
        button.isEnabled = false
        return button
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
        
        view.addSubview(filterImageView)
        view.addSubview(intensityLabel)
        view.addSubview(intensitySlider)
        view.addSubview(chooseFilterLabel)
        view.addSubview(chooseFilterButton)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            filterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            filterImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            filterImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 1.5),
            
            intensityLabel.topAnchor.constraint(lessThanOrEqualTo: filterImageView.bottomAnchor, constant: 20),
            intensityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            intensitySlider.topAnchor.constraint(equalTo: filterImageView.bottomAnchor, constant: 20),
            intensitySlider.leadingAnchor.constraint(equalTo: intensityLabel.trailingAnchor, constant: 30),
            intensitySlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            chooseFilterLabel.topAnchor.constraint(equalTo: intensityLabel.bottomAnchor, constant: 20),
            chooseFilterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            chooseFilterButton.centerYAnchor.constraint(equalTo: chooseFilterLabel.centerYAnchor),
            chooseFilterButton.leadingAnchor.constraint(lessThanOrEqualTo: chooseFilterLabel.trailingAnchor, constant: 30),
            chooseFilterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func chooseImage() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func sliderChanged() {
        applyFilter()
    }
    
    @objc private func chooseFilter() {
        let filtersController = FiltersViewController(filterManager: filterManager)
        filtersController.modalPresentationStyle = .popover
        
        let popoverPresentationController = filtersController.popoverPresentationController
        popoverPresentationController?.permittedArrowDirections = .down
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.delegate = self
        popoverPresentationController?.sourceRect = chooseFilterButton.frame
        filtersController.preferredContentSize = CGSize(width: chooseFilterButton.frame.width + 50, height: view.frame.height / 1.5)
        present(filtersController, animated: true, completion: nil)
        
        filtersController.chosenFilter = { [weak self] filter in
            guard let self = self else { return }
            self.chosenFilter = filter
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func applyFilter() {
        guard  let image = chosenImage else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.filterImageView.image = self.filterManager.applyFilter(image: image, filterName: self.chosenFilter, intensity: CGFloat(self.intensitySlider.value))
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        chosenImage = image
        filterImageView.image = image
        title = chosenFilter
        intensitySlider.isEnabled = true
        chooseFilterButton.isEnabled = true
        applyFilter()
        
        dismiss(animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        true
    }
}
