//
//  GamesViewModel.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

//import Foundation
//
//class GamesViewModel {
//    private var apiServices = ApiServices()
//    private var gamesData = [Results]()
//    func fetchData(completion: @escaping () -> Void) {
//        apiServices.getData { [weak self] (result) in
//            switch result {
//            case .success(let listOf):
//                self?.gamesData = listOf.results
//                completion()
//            case .failure(let error):
//                print("error: ", error)
//            }
//        }
//    }
//    func numberOfRowsInSection() -> Int {
//        if gamesData.count != 0 {
//            return gamesData.count
//        }
//        return 0
//    }
//    func cellForRowAt (indexPath: IndexPath) -> Results {
//        return gamesData[indexPath.row]
//    }
//}

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var searchQuery = ""
    var searchCancellable: AnyCancellable?

    @Published var fetchedGames: [Results]?

    init() {
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    self.fetchedGames = nil
                } else {
                    print(str)
                    self.searchCharacter()
                }
            })
    }

    func searchCharacter() {
        let publicKey = "f5a9d29821874524a7c5e0f5db13ee14"
        let searchKey = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let url = "https://api.rawg.io/api/games?search=\(searchKey)&key=\(publicKey)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            guard let APIData = data else {
                print("no data found")
                return
            }
            do {
                let games = try JSONDecoder().decode(GamesModel.self, from: APIData)
                DispatchQueue.main.async {
                    if self.fetchedGames == nil {
                        self.fetchedGames = games.results
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
