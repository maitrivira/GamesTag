//
//  GamesRow.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GamesRow: View {
    var game: Results
    var body: some View {
        HStack {
            WebImage(url: URL(string: game.backgroundImage))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 0) {
                Text(game.name)
                    .font(.system(size: 20))
                Text(String(game.rating))
                    .font(.system(size: 14))
                    .lineLimit(3)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 28)
            .padding(.leading, 8)
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}
