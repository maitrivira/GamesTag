//
//  GamesLIst.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

struct GamesList: View {
    @State var searchText = ""
    @State var isSearching = false
    @EnvironmentObject var gameData: GameViewModel
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $gameData.searchQuery, isSearching: $isSearching)
                if let games = gameData.fetchedGames {
                    if games.isEmpty {
                        Text("No Results Found")
                            .padding(.top, 20)
                    } else {
                        List(games) { game in
                            ZStack {
                                GamesRow(game: game)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                NavigationLink(destination:
                                    GamesDetail(game: game)
                                ) {
                                    EmptyView()
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                        .listStyle(InsetListStyle())
                        .padding(.top, 2)
                    }
                } else {
                    if gameData.searchQuery != "" {
                        ProgressView()
                            .padding(.top, 20)
                    }
                }
            }
            .navigationBarTitle(Text("Pahlawan Indonesia"), displayMode: .inline)
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    var body: some View {
        HStack {
            HStack {
                TextField("Search", text: $searchText)
                    .padding(.leading, 35)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(10)
            .background(Color(.systemGray5))
            .cornerRadius(18)
            .padding(.horizontal)
            .onTapGesture {
                isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching {
                        Button(action: { searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                }.padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, -12)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
        .padding(.top)
    }
}
