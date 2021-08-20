//
//  ApiServices.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import UIKit
import Foundation

struct ApiServices {
    private var games: URLSessionDataTask?
    func getData(completion: @escaping (Result<GamesModel, Error>) -> Void) {
        //https://api.rawg.io/api/games?key=f5a9d29821874524a7c5e0f5db13ee14
        let url = "https://api.rawg.io/api/games"
        let apiKey = "f5a9d29821874524a7c5e0f5db13ee14"
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]

        let request = URLRequest(url: components.url!)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("DataTask error : \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                print("DATA: \(data)")
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(GamesModel.self, from: data)
                    print("data apiservice", jsonData)
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let error {
                    print("data error apiservice", error)
                    completion(.failure(error))
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        task.resume()
    }
}
