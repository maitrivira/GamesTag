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
    func addBio(name: String, job: String, desc: String) {
        defaults.set(name, forKey: "name")
        defaults.set(job, forKey: "job")
        defaults.set(desc, forKey: "desc")
        print("saved to userdefaults")
    }
    func getName() -> String {
        guard let name = defaults.object(forKey: "name") as? String else {
            return ""
        }
        return name
    }
    func getJob() -> String {
        guard let job = defaults.object(forKey: "job") as? String else {
            return ""
        }
        return job
    }
    func getDesc() -> String {
        guard let desc = defaults.object(forKey: "desc") as? String else {
            return ""
        }
        return desc
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
