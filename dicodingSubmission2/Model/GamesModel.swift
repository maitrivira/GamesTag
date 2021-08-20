//
//  GamesModel.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

struct GamesModel: Codable {
    let results: [Results]
    private enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Results: Identifiable, Codable {
    let id: Int
    let name: String
    let released: String
    let rating: Double
    let backgroundImage: String
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case released = "released"
        case rating = "rating"
        case backgroundImage = "background_image"
    }
}

let dummy: [Results] = [
    .init(id: 1, name: "GTA", released: "2020", rating: 4.4, backgroundImage: "maitri"),
    .init(id: 2, name: "pokemon", released: "2020", rating: 4.4, backgroundImage: "maitri"),
    .init(id: 3, name: "gensin impact", released: "2020", rating: 4.4, backgroundImage: "maitri"),
    .init(id: 4, name: "power ranger", released: "2020", rating: 4.4, backgroundImage: "maitri"),
    .init(id: 5, name: "dota", released: "2020", rating: 4.4, backgroundImage: "maitri")
]
