//
//  NewsNetworkService.swift
//  Network
//
//  Created by Nikolai Sokol on 01.06.2021.
//

import UIKit

struct NewsNetworkService: NewsNetworkServiceProtocol {
    
    private let session: URLSession = .shared
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    private let apiKey = "84c2f940d46e414cb934bb89de1693b0"
    
    public func getNews(country: String, category: String, completion: @escaping (Result<[News], Error>) -> Void) {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "categoty", value: category.lowercased())
        ]
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    let news = decodedResponse.articles
                    completion(.success(news))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    completion(.failure(DecodingError.dataCorrupted(context)))
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(DecodingError.keyNotFound(key, context)))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(DecodingError.valueNotFound(value, context)))
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(DecodingError.typeMismatch(type, context)))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    public func loadImage(imageUrl: String, completion: @escaping((UIImage) -> Void)) {
        var urlToImage = imageUrl
        if let afterJpg = urlToImage.range(of: ".jpg") {
            urlToImage.removeSubrange(afterJpg.upperBound..<urlToImage.endIndex)
        }
        guard let url = URL(string: urlToImage) else {
            completion(UIImage(named: "noImage") ?? UIImage())
            return
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        session.dataTask(with: request) { data, _, _ in
            if let data = data {
                guard let image = UIImage(data: data) else {
                    completion(UIImage(named: "noImage") ?? UIImage())
                    return }
                completion(image)
            }
        }.resume()
    }
}
