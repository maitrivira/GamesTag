//
//  Search.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 07/09/21.
//

import SwiftUI

struct Search: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @State var isSearching: Bool = false
    var body: some View {
        NavigationView {
            VStack {
              SearchBar(searchText: $searchViewModel.searchTerm, isSearching: $isSearching)
              if searchViewModel.games.isEmpty {
                EmptyStateView(view: "search")
              } else {
                List {
                    ForEach(searchViewModel.games, id: \.self.id) { game in
                        ZStack {
                            NavigationLink(destination: GamesDetail(game: game, gameData: dummyGameData, type: "search")) {
                                GamesRow(game: game, gameFavorite: dummyGameData, type: "search")
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
            .navigationBarTitle("Game Search", displayMode: .inline)
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
                    .textCase(.lowercase)
            }
            .padding(10)
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .padding(.horizontal)
            .onTapGesture {
                isSearching = true
                print($searchText)
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching {
                        Button(action: {
                            searchText = ""
                        }, label: {
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
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color("Gray"))
                        .padding(.trailing)
                        .padding(.leading, -12)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
        .padding(.top, 10)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(searchViewModel: SearchViewModel())
    }
}
