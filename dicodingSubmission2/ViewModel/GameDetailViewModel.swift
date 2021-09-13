//
//  GameDetailViewModel.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 11/09/21.
//

import Foundation
import Combine

class GameDetailViewModel: ObservableObject {
    @Published var id: Int = 0
    @Published var gameDetail: [GamesDetailModel] = []
    private let gameDetailServices: GameDetailServices = GameDetailServices()
    private var cancellable = Set<AnyCancellable>()
    @Published var desc: String = ""
    init() {
        $id
            .sink(receiveValue: getDetail(of:))
            .store(in: &cancellable)
    }
    private func getDetail(of id: Int) {
        desc.removeAll()
        gameDetailServices.loadDetail(detailId: id) { [weak self] detail in
            DispatchQueue.main.async {
                self?.desc = detail
            }
        }
    }
}
