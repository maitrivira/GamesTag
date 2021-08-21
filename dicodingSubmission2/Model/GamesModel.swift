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
    let genres, tags: [Genres]
    private enum CodingKeys: String, CodingKey {
        case id, name, released, rating, genres, tags
        case backgroundImage = "background_image"
    }
}

struct Genres: Identifiable, Codable {
    let id: Int
    let name: String
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}
