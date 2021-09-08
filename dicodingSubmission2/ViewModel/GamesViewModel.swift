//
//  GamesViewModel.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var games: [Results] = []
    let apiServices = ApiServices()
    init() {
        fetchData()
    }
    func fetchData() {
        apiServices.downloadGames { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.games = listOf.results
            case .failure(let error):
                print("error: ", error)
            }
        }
    }
}
