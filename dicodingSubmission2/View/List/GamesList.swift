//
//  GamesLIst.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

struct GamesList: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var gameData: GameViewModel
    @State var searchText = ""
    @State var isSearching = false
    @State var showPageView = false
    var body: some View {
        NavigationView {
            VStack {
                if gameData.games.isEmpty {
                    List {
                        ForEach(dummyData, id: \.self.id) { data in
                            ZStack {
                                GamesRow(game: data, gameFavorite: dummyGameData, type: "home")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .buttonStyle(PlainButtonStyle())
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .redacted(reason: .placeholder)
                } else {
                    List {
                        ForEach(gameData.games, id: \.self.id) { game in
                            ZStack {
                                NavigationLink(destination: GamesDetail(game: game, gameData: dummyGameData, type: "home")) {
                                    GamesRow(game: game, gameFavorite: dummyGameData, type: "home")
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Games List", displayMode: .inline)
            .onAppear {
                UITableViewCell.appearance().selectionStyle = .none
            }
            .navigationBarItems(trailing:
                NavigationLink(destination: About(edit: false), label: {
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.white)
                })
            )
        }
    }
}
