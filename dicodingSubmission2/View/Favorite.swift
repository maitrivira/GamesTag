//
//  Favorite.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 03/09/21.
//

import SwiftUI

struct Favorite: View {
    @EnvironmentObject var favorite: Favorites
    var body: some View {
        NavigationView {
            VStack {
                if favorite.getData().isEmpty {
                    Text("No Data")
                } else {
                    List {
                        ForEach(favorite.getData()) { data in
                            ZStack {
                                GamesRow(game: data)
                                NavigationLink(destination:
                                    GamesDetail(game: data)
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
            .navigationBarTitle(Text("Favorite"), displayMode: .inline)
        }
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}
