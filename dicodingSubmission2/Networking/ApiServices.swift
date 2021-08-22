//
//  ApiServices.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 20/08/21.
//

import SwiftUI

class ApiServices {
    func downloadData(completion: @escaping (Result<GamesModel, Error>) -> Void) {
        let publicKey = "f5a9d29821874524a7c5e0f5db13ee14"
        let url = "https://api.rawg.io/api/games"
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "key", value: publicKey)
        ]
        let request = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("No Data Error Downloading")
                return
            }
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
        }.resume()
    }
}
