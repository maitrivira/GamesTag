//
//  Favorites.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 02/09/21.
//

import SwiftUI

class Favorites: ObservableObject {
    public var newData: [Results]
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    init() {
        self.newData = []
    }
    func contains(_ game: Results) -> Bool {
        getData().contains { $0.id == game.id }
    }
    func add(_ game: Results) {
        objectWillChange.send()
        newData = getData()
        newData.append(game)
        if let encoded = try? encoder.encode(newData) {
            defaults.set(encoded, forKey: "favorites")
        }
        print("saved to userdefaults")
    }
    func remove(_ game: Results) {
        objectWillChange.send()
        let index = getData().firstIndex { $0.id == game.id }
        guard let getIndex = index else {
            return
        }
        newData = getData()
        newData.remove(at: getIndex)
        if let encoded = try? encoder.encode(newData) {
            defaults.set(encoded, forKey: "favorites")
        }
        print("newData deleted")
    }
    func getData() -> [Results] {
        if let objects = defaults.value(forKey: "favorites") as? Data {
            let decoder = JSONDecoder()
            if let objectDecoded = try? decoder.decode(Array.self, from: objects) as [Results] {
                return objectDecoded
            } else {
                return []
            }
        } else {
            return []
        }
    }
}
