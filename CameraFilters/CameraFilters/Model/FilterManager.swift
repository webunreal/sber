//
//  FilterManager.swift
//  CameraFilters
//
//  Created by Nikolai Sokol on 08.06.2021.
//

import UIKit

final class FilterManager {
    
    public let filters = CIFilter.filterNames(inCategories: nil).filter {
        CIFilter(name: $0)?.inputKeys.contains("inputImage") ?? false &&
            (CIFilter(name: $0)?.inputKeys.contains("inputIntensity") ?? false ||
                CIFilter(name: $0)?.inputKeys.contains("inputRadius") ?? false)
    }
    
    public func applyFilter(image: UIImage, filterName: String, intensity: CGFloat) -> UIImage {
        DispatchQueue.global().sync {
            let context = CIContext()
            
            guard let filter = CIFilter(name: filterName) else {
                return image
            }
            
            let ciImage = CIImage(image: image)
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            
            if filter.inputKeys.contains("inputIntensity") {
                filter.setValue(intensity, forKey: kCIInputIntensityKey)
            }
            
            if filter.inputKeys.contains("inputRadius") {
                filter.setValue(intensity * 100, forKey: kCIInputRadiusKey)
            }
            
            guard let outputImage = filter.outputImage else {
                return image
            }
            guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
                return image
            }
            
            let finalImage = UIImage(cgImage: cgImage)
            return finalImage
        }
    }
}
