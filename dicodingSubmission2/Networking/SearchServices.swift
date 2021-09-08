//
//  Search.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 07/09/21.
//

import Foundation

class SearchServices {
    private var dataTask: URLSessionDataTask?
    func loadGames(searchTerm: String, completion: @escaping(([Results]) -> Void)) {
      dataTask?.cancel()
      guard let url = buildUrl(forTerm: searchTerm) else {
        completion([])
        return
      }
      dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
        guard let data = data else {
          completion([])
          return
        }
        do {
            let gameResponse = try JSONDecoder().decode(GamesModel.self, from: data)
            completion(gameResponse.results)
        } catch let err {
            print(err)
        }
      }
      dataTask?.resume()
    }
    private func buildUrl(forTerm searchTerm: String) -> URL? {
        guard !searchTerm.isEmpty else { return nil }
        let publicKey = "f5a9d29821874524a7c5e0f5db13ee14"
        let url = "https://api.rawg.io/api/games"
        let queryItems = [
            URLQueryItem(name: "search", value: searchTerm),
            URLQueryItem(name: "key", value: publicKey)
        ]
        var components = URLComponents(string: url)
        components?.queryItems = queryItems
        return components?.url
    }
}
