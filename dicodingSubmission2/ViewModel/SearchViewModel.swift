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
    @Published public private(set) var games: [ResultsViewModel] = []
    private let searchServices: SearchServices = SearchServices()
    private let artworkLoader: ArtworkLoader = ArtworkLoader()
    private var disposables = Set<AnyCancellable>()
    init() {
      $searchTerm
        .sink(receiveValue: loadGame(searchTerm:))
        .store(in: &disposables)
    }
    private func loadGame(searchTerm: String) {
        print("load game")
        games.removeAll()
        artworkLoader.reset()
        searchServices.loadGames(searchTerm: searchTerm) { game in
            print("load game services")
            game.forEach { self.appendGame(result: $0) }
        }
    }
    private func appendGame(result: Results) {
        let resultViewModel = ResultsViewModel(result: result)
        DispatchQueue.main.async {
            print("append game")
            self.games.append(resultViewModel)
        }
        artworkLoader.loadArtwork(forGame: result) { image in
            DispatchQueue.main.async {
                print("append game loader")
                resultViewModel.backgroundImage = image
            }
        }
    }
}

class ResultsViewModel: Identifiable, ObservableObject {
    let id: Int
    let name: String
    let released: String
    let rating: Double
    @Published var backgroundImage: Image?
    init(result: Results) {
        self.id = result.id
        self.name = result.name
        self.released = result.released
        self.rating = result.rating
    }
}
