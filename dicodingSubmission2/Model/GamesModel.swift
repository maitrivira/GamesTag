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
