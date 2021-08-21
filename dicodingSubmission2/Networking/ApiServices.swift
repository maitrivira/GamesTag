//
//  ApiServices.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 20/08/21.
//

import SwiftUI

class ApiServices: ObservableObject {
    @Published var games: [Results] = []
    let gameViewModel = GameViewModel()
    init() {
        fetchData()
    }
    func fetchData() {
        gameViewModel.downloadData { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.games = listOf.results
            case .failure(let error):
                print("error: ", error)
            }
        }
    }
}
