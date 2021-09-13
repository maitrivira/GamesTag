//
//  GameDetailServices.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 11/09/21.
//

import Foundation

class GameDetailServices {
    private var dataTask: URLSessionDataTask?
    func loadDetail(detailId: Int, completion: @escaping((String) -> Void)) {
        dataTask?.cancel()
        guard let url = buildUrl(forTerm: detailId) else {
          completion("")
          return
        }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
          guard let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("No Data Error Downloading")
                completion("")
                return
          }
          do {
                let decoder = JSONDecoder()
                let gameResponse = try decoder.decode(GamesDetailModel.self, from: data)
                DispatchQueue.main.async {
                    completion(gameResponse.description)
                }
          } catch let err {
                print("data error apiservice", err)
                completion("")
          }
        }
        dataTask?.resume()
    }
    private func buildUrl(forTerm detailId: Int) -> URL? {
        guard detailId != 0 else { return nil }
        let publicKey = "f5a9d29821874524a7c5e0f5db13ee14"
        let url = "https://api.rawg.io/api/games/\(detailId)"
        let queryItems = [
            URLQueryItem(name: "key", value: publicKey)
        ]
        var components = URLComponents(string: url)
        components?.queryItems = queryItems
        return components?.url
    }
}
