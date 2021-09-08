//
//  GamesLIst.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

struct GamesList: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var searchText = ""
    @State var isSearching = false
    @State var showPageView = false
    @EnvironmentObject var gameData: GameViewModel
    var body: some View {
        NavigationView {
            VStack {
                if gameData.games.isEmpty {
                    List {
                        ForEach(dummyData) { data in
                            ZStack {
                                GamesRow(game: data)
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
                        ForEach( gameData.games.filter {
                            searchText.isEmpty || $0.name.lowercased().contains(searchText)
                        }) { game in
                            ZStack {
                                GamesRow(game: game)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                NavigationLink(destination:
                                    GamesDetail(game: game)
                                ) {
                                    EmptyView()
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .background(Color("Navy"))
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
