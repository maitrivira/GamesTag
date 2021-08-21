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
                    .font(.title3)
                    .bold()
                Spacer()
                    .frame(minHeight: 10, maxHeight: 10)
                HStack {
                    Text(game.released)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                    Text("\(String(game.rating))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding(.trailing, 28)
            .padding(.leading, 8)
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}
