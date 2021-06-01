//
//  NewsNetworkServiceProtocol.swift
//  Network
//
//  Created by Nikolai Sokol on 01.06.2021.
//

import UIKit

protocol NewsNetworkServiceProtocol {
    func getNews(country: String, category: String, completion: @escaping (Result<[News], Error>) -> Void)
    func loadImage(imageUrl: String, completion: @escaping((UIImage) -> Void))
}
