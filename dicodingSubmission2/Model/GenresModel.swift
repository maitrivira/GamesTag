//
//  GenresModel.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 14/09/21.
//

struct Genres: Identifiable, Codable {
    let id: Int
    let name: String
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}
