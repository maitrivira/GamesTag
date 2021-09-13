//
//  GameDetailModel.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 11/09/21.
//

struct GamesDetailModel: Codable {
    let name, description: String
    private enum CodingKeys: String, CodingKey {
        case name
        case description = "description_raw"
    }
}
