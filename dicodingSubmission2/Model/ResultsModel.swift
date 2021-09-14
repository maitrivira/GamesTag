//
//  ResultsModel.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 14/09/21.
//

struct Results: Identifiable, Codable {
    let id: Int
    let name: String
    let released: String?
    let rating: Double
    let backgroundImage: String?
    let genres, tags: [Genres]
    private enum CodingKeys: String, CodingKey {
        case id, name, released, rating, genres, tags
        case backgroundImage = "background_image"
    }
}
