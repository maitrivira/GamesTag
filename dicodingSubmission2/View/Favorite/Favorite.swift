//
//  Favorite.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 03/09/21.
//

import SwiftUI

struct Favorite: View {
    @EnvironmentObject var favorite: FavoriteViewModel
    var body: some View {
        NavigationView {
            VStack {
                if favorite.gameData.isEmpty {
                    EmptyStateView(view: "favorite")
                } else {
                    List {
                        ForEach(favorite.gameData) { data in
                            ZStack {
                                NavigationLink(destination: GamesDetail(game: dummyResults, gameData: data, type: "favorite")) {
                                    GamesRow(game: dummyResults, gameFavorite: data, type: "favorite")
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle(Text("Favorite"), displayMode: .inline)
        }
        .onAppear {
            favorite.getData()
        }
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}
