//
//  SearchViewModel.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 07/09/21.
//

import Combine
import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published public private(set) var games: [Results] = []
    private let searchServices: SearchServices = SearchServices()
    private var disposables = Set<AnyCancellable>()
    init() {
      $searchTerm
        .sink(receiveValue: loadGame(searchTerm:))
        .store(in: &disposables)
    }
    private func loadGame(searchTerm: String) {
        games.removeAll()
        searchServices.loadGames(searchTerm: searchTerm) { [weak self] game in
            DispatchQueue.main.async {
                self?.games = game
            }
        }
    }
}
